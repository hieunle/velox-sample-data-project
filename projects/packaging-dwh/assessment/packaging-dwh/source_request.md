# Source request — packaging-dwh  (run-01, 2026-10-27)

**Line 1 — access.** Databricks workspace: ❌ none yet. The assessment ran without a workspace by
choice (OQ-01 records the decision context). Source access: the test copy (SYS-2, `bore.pub,60747`,
database `veloxpool`) has a read-only login for the migration. Velox's Scope step checks each
accepted source system with the person's own sign-in. No credential is held in this folder or run.

## Required — the core conclusions are impossible without these

| # | Source | Why | How to obtain | Client owner | Status |
|---|---|---|---|---|---|
| R1 | Read-only access to **production** `PACKDWH01\veloxpool` incl. `msdb` and the report server DB | Real volumes, usage and job history; the test copy is demo-sized (FND-15) | DBA creates a read-only login or service principal path; name the March 2027 deadline | DBA Marta K. | ❌ only the test copy (SYS-2) |
| R2 | **Complete object scripts**: sequences (`sales.seq_Invoice`, `supply.seq_Snapshot`), functions, triggers, synonyms, the `wms` schema, re-scripted tables | The DDL export is incomplete and edited (FND-05, FND-14); input for Lakebridge Analyzer | SSMS *Generate Scripts*, one file per object, or `mssql-scripter` | DBA Marta K. | ⚠️ partial — src-ddl, src-proc-*, src-view-* |
| R3 | **SSIS packages** (`.dtsx` / project files) | The config names SSIS configurations; none supplied | Export from SSISDB or the project folder | DBA Marta K. | ❌ |
| R4 | **SQL Agent job definitions**: `sysjobs`, `sysjobsteps`, `sysjobschedules` | Settles who calls the procedures (FND-01, OQ-05) | Script the jobs, or query `msdb` | DBA Marta K. | ❌ |
| R5 | **Job history ≥ 90 days** incl. a month-end and a quarter-end | Real runtimes and the critical path; the "90d" file holds one run per step (FND-16) | `msdb.dbo.sysjobhistory` export | DBA Marta K. | ⚠️ src-exp-jobhist — one sample per step |
| R6 | **Usage log ≥ 90 days** incl. month-end and quarter-end | Without it nothing may be called orphan | Query Store if enabled; else SQL Audit; DMV figures need `sqlserver_start_time` | DBA Marta K. | ❌ — DMV dates only, no window (src-exp-rowcounts) |
| R7 | **Report inventory with execution history** | Report usage and report-level logic | SSRS `ReportServer.dbo.Catalog` + `ExecutionLog3`; Power BI activity log; `.rdl` and `.pbix` files | Finance BI, Operations BI | ❌ |
| R8 | **Production row counts and sizes** per table | Volume, backfill and sizing (FND-15) | `sys.dm_db_partition_stats` on production | DBA Marta K. | ❌ — test copy only |
| R9 | **Missing loaders**: LIMS feed, MES feeds of MachineEvent and EnergyReading, master-data loads, producer of `wms.stock_extract`, the sustainability extract, the writer of credit notes | Feeds of hot tables have no code in the folder (FND-05, OQ-09, OQ-16) | Code repositories, ETL02 file system, application owners | DBA, Finance BI, Quality | ❌ |
| R10 | **MES linked server definition** (`MES_EU`) | Config and code name different databases (OQ-08) | `sp_helplinkedsrvlogin` / `sys.servers` script, no credentials | DBA Marta K. | ❌ |

## Recommended

| # | Source | Why | How to obtain | Client owner | Status |
|---|---|---|---|---|---|
| C1 | Tickets DWH-412, DWH-401, DWH-388 and the last 2–3 years of DWH changes | Why rules changed | Jira / ServiceNow export | DWH team | ⚠️ summaries in src-spec-01 only |
| C2 | UAT scripts or expected outputs for OEE and receivables | Literal input/output for reconciliation | QA team, old project folders | Operations BI, Finance BI | ❌ |
| C3 | Current SQL Server licence and infrastructure cost | Business-case baseline | Finance / vendor invoices | Sponsor | ❌ |
| C4 | Report SLA and business calendar (month-end close, freeze periods) | Cut-over windows | Interview report owners | Finance BI, Operations BI | ⚠️ refresh times only (src-spec-01) |
| C5 | Downstream consumer list beyond Power BI and SSRS | Direct ODBC / Excel readers | `sys.dm_exec_sessions` sampled over days; ask "who complains when it is late?" | DBA Marta K. | ❌ |
| C6 | SAP file layouts and the share's archive policy | File ingestion design (FND-20) | SAP basis team | SAP team (name: ?) | ❌ |

## Optional

| # | Source | Why | Status |
|---|---|---|---|
| O1 | Masked sample rows (≤ 20 per table) of the hot tables | Profiling NULL payment terms, product 7 SKUs | ❌ |
| O2 | Lakebridge Analyzer output on the re-exported scripts | Measured complexity per object | ❌ needs a signed-in workspace, which this run does not use |
| O3 | Data-protection guidance for contact and staff data (OQ-13) | Masking design | ❌ |
