# Packaging DWH — functional specification (v2.3, 2019-05, amended 2024-11)

Nordic Pack AB runs one SQL Server 2019 warehouse, `PACKDWH01\veloxpool`, for its twelve converting
plants (cartons, closures, straws, pouches). Four subject areas, one schema each: `mfg` (plants,
lines, machines, production runs, maintenance, energy), `sales` (customers, orders, invoices, price
lists), `supply` (suppliers, purchase orders, warehouses, inventory, shipments) and `quality`
(inspections, lab tests, complaints).

## Sources

| Area | Source | How it arrives |
| --- | --- | --- |
| mfg | MES (SQL Server `mes-eu.packaging.local`, linked server `MES_EU`) | `mfg.sp_Load_ProductionRun` nightly 01:30 |
| sales, supply | SAP ECC flat files on `\\fs01\erp_export` | `jobs/dwh_nightly.py` lands them with bcp |
| supply.InventorySnapshot | WMS extract `wms.stock_extract` | `supply.sp_Snapshot_Inventory` 23:55 |
| quality | QMS web app writes `quality.Complaint` directly; LIMS loads `quality.LabTestResult` hourly | application |

## Business rules the warehouse enforces

| Rule | Statement | Where |
| --- | --- | --- |
| R-OEE-1 | `Oee = Availability × Performance × QualityRate`, each between 0 and 1 | `mfg.sp_Load_ProductionRun` |
| R-OEE-2 | `UnitsRejected ≤ UnitsProduced` on every production run | `mfg.sp_Load_ProductionRun` (throws) |
| R-OEE-3 | A line's daily OEE is weighted by `DurationMinutes`, never a plain average | `mfg.vw_DailyOee` |
| R-INV-1 | `Invoice.NetAmount` equals the sum of its order lines' `LineAmount` | `sales.sp_Build_Invoice` |
| R-INV-2 | `GrossAmount = NetAmount + TaxAmount`; credit notes carry negative amounts | `sales.sp_Build_Invoice` |
| R-INV-3 | `DueDate = IssuedAt + Customer.PaymentTermsDays` | `sales.sp_Build_Invoice` |
| R-INV-4 | `StockValueEur = OnHandUnits × UnitCostEur` | `supply.sp_Snapshot_Inventory` |
| R-INV-5 | `DaysOfCover = OnHandUnits / average daily shipped units of the last 28 days`, NULL when nothing shipped | `supply.sp_Snapshot_Inventory` |
| R-INV-6 | Unpaid after `DueDate` is overdue; dunning level 1 after 7 days, 2 after 30, 3 after 60 | `sales.vw_OpenReceivables` |
| R-CMP-1 | A complaint closes only with a root cause; recalls close through the recall board | `quality.sp_Close_Complaint` |
| R-KEY-1 | `sales.Customer.ContactEmail` is unique ignoring case (the column is `CI_AS`) | application, not enforced in SQL |
| R-KEY-2 | `mfg.PackagingProduct.Sku` is unique; `ProductKey` was unique until DWH-412 | see ticket |

## Known issues (open tickets)

- **DWH-412** — `mfg.PackagingProduct` holds `ProductKey = 7` twice since the 2021-03 load. The
  primary key was dropped rather than the row; Power BI de-duplicates in the model. Must be fixed
  in the migration, not copied.
- **DWH-401** — `supply.sp_Snapshot_Inventory` scans 28 days of `sales.OrderLine` per product; 40
  minutes at month end.
- **DWH-388** — `mfg.ProductionRun.Oee` was stored as the MES value before 2024-11; rows older than
  that can differ from R-OEE-1 by rounding.

## Consumers

- Power BI datasets: *Plant performance* (`mfg.vw_DailyOee`, 06:00), *Sales cockpit* (`sales.*`, 06:30).
- SSRS: `rpt_open_receivables` (`sales.vw_OpenReceivables`, 07:00), `rpt_complaints_weekly` (Mondays).
- The QMS web app reads and writes `quality.Complaint` (OLTP use of a warehouse table, to be split).
- Monthly extract to the group sustainability platform: `mfg.EnergyReading`, `supply.Shipment.Co2Kg`.
