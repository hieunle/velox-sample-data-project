# Packaging DWH — functional specification (v2.3, 2019-05, amended 2024-11)

Nordic Pack AB runs one PostgreSQL warehouse, `packdwh-pg01/veloxpool`, for its twelve converting
plants (cartons, closures, straws, pouches). Four subject areas, one schema each: `mfg` (plants,
lines, machines, production runs, maintenance, energy), `sales` (customers, orders, invoices, price
lists), `supply` (suppliers, purchase orders, warehouses, inventory, shipments) and `quality`
(inspections, lab tests, complaints).

## Sources

| Area | Source | How it arrives |
| --- | --- | --- |
| mfg | MES (PostgreSQL `mes-eu.packaging.local`, `postgres_fdw` foreign schema `mes_eu`) | `mfg.sp_load_productionrun` nightly 01:30 |
| sales, supply | SAP ECC flat files on `/mnt/erp_export` | `jobs/dwh_nightly.py` lands them with `COPY` |
| supply.inventorysnapshot | WMS extract `wms.stock_extract` | `supply.sp_snapshot_inventory` 23:55 |
| quality | QMS web app writes `quality.complaint` directly; LIMS loads `quality.labtestresult` hourly | application |

Schedules run in `pg_cron` (`cron.job`); the history is exported in `exports/cron_job_run_details_90d.csv`.

## Business rules the warehouse enforces

| Rule | Statement | Where |
| --- | --- | --- |
| R-OEE-1 | `oee = availability × performance × qualityrate`, each between 0 and 1 | `mfg.sp_load_productionrun` |
| R-OEE-2 | `unitsrejected ≤ unitsproduced` on every production run | `mfg.sp_load_productionrun` (raises) |
| R-OEE-3 | A line's daily OEE is weighted by `durationminutes`, never a plain average | `mfg.vw_dailyoee` |
| R-INV-1 | `invoice.netamount` equals the sum of its order lines' `lineamount` | `sales.sp_build_invoice` |
| R-INV-2 | `grossamount = netamount + taxamount`; credit notes carry negative amounts | `sales.sp_build_invoice` |
| R-INV-3 | `duedate = issuedat + customer.paymenttermsdays` | `sales.sp_build_invoice` |
| R-INV-4 | `stockvalueeur = onhandunits × unitcosteur` | `supply.sp_snapshot_inventory` |
| R-INV-5 | `daysofcover = onhandunits / average daily shipped units of the last 28 days`, NULL when nothing shipped | `supply.sp_snapshot_inventory` |
| R-INV-6 | Unpaid after `duedate` is overdue; dunning level 1 after 7 days, 2 after 30, 3 after 60 | `sales.vw_openreceivables` |
| R-CMP-1 | A complaint closes only with a root cause; recalls close through the recall board | `quality.sp_close_complaint` |
| R-KEY-1 | `sales.customer.contactemail` is unique ignoring case (`lower(contactemail)`); PostgreSQL compares case-sensitively, so the column holds case variants | application, not enforced in SQL |
| R-KEY-2 | `mfg.packagingproduct.sku` is unique; `productkey` was unique until DWH-412 | see ticket |

## Known issues (open tickets)

- **DWH-412** — `mfg.packagingproduct` holds `productkey = 7` twice since the 2021-03 load. The
  primary key was dropped rather than the row; Power BI de-duplicates in the model. Must be fixed
  in the migration, not copied.
- **DWH-401** — `supply.sp_snapshot_inventory` scans 28 days of `sales.orderline` per product; 40
  minutes at month end, and it hit `statement_timeout` on 2026-08-31.
- **DWH-388** — `mfg.productionrun.oee` was stored as the MES value before 2024-11; rows older than
  that can differ from R-OEE-1 by rounding.

## Consumers

- Power BI datasets (on-premises gateway): *Plant performance* (`mfg.vw_dailyoee`, 06:00), *Sales cockpit* (`sales.*`, 06:30).
- Metabase: *Open receivables* (`sales.vw_openreceivables`, 07:00), *Complaints weekly* (Mondays).
- The QMS web app reads and writes `quality.complaint` (OLTP use of a warehouse table, to be split).
- Monthly extract to the group sustainability platform: `mfg.energyreading`, `supply.shipment.co2kg`.
