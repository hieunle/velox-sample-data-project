# Minh Phat Retail — MP_DWH (synthetic)

SQL Server 2016 data warehouse feeding a nightly SQL Agent chain, one SSIS load, SSRS reports and a
Finance Excel workbook. The client wants to move it to Databricks.

- `sources/code/` — DDL for 15 tables, 6 procedures, `pkg_pos_load.dtsx`, `rpt_daily_revenue.rdl`
- `sources/exports/` — Query Store reads (396 d), job definitions and 120 d of history, SSRS log, row counts, `CFG_PARAM`
- `sources/docs/` — 2016 functional spec, kickoff deck notes, DBA interview

Deliverables produced by a session belong under `discovery/`, `migration/` or `validation/` in this folder.
