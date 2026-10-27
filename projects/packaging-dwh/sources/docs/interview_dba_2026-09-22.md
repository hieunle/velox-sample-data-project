# Interview — DBA (Marta K.), 2026-09-22, 45 min

**Platform.** SQL Server 2019 Enterprise on `PACKDWH01`, 2 TB data file, 16 cores. Nightly window
01:00–05:30 and it is full: the inventory snapshot (DWH-401) and the SAP landing fight for it.
Licence renewal is 2027-03, which is the real deadline for the move.

**What is hot.** `mfg.ProductionRun`, `mfg.MachineEvent`, `mfg.EnergyReading`, `sales.OrderLine`,
`sales.Invoice`, `supply.InventorySnapshot`, `quality.Inspection`, `quality.LabTestResult` take almost
all reads (see `exports/table_rowcounts.csv`). `mfg.PackagingProduct`, `mfg.Material` and `supply.Supplier`
are small and read by every join.

**What is cold.** `sales.PriceList` rows older than two years are never read; `supply.Shipment`
before 2024 only for the sustainability extract once a year.

**Pitfalls.** The duplicate `ProductKey 7` (DWH-412) breaks any merge that assumes a key. Every
text column is `SQL_Latin1_General_CP1_CI_AS` except `quality.Inspection.BatchCode`, which is
case-sensitive on purpose: `B1234a` and `B1234A` are two batches. `ReceivedAt`, `ApprovedAt`,
`StartedAt` in several tables are `datetimeoffset` in three plant time zones; the Power BI model
converts to UTC and nobody remembers exactly where. `MONEY` columns in `quality.Complaint` and
`sales.*` round to four decimals.

**Identity keys.** `sales.Customer`, `supply.Supplier`, `quality.Inspection`, `mfg.MaintenanceWorkOrder`
and `supply.Shipment` use IDENTITY; the SAP loads depend on the generated values being stable.

**Security.** One read-only login per consumer. For the migration a login `velox_reader`
(db_datareader + VIEW DEFINITION) was created on the test copy; see `config/connections.ini`.

**Her ask.** "Move the four hot fact tables first and prove the OEE and receivables numbers match
to the cent before anyone touches the Power BI models."
