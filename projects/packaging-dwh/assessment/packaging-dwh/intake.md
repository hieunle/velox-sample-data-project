# Intake — packaging-dwh  (run-01, 2026-10-27)

Client: Nordic Pack AB (synthetic). Run folder: `runs/2026-10-27_run-01-member/`.
Approach chosen by the person: **without a workspace** — code and documents only (2026-10-27).

## Team knowledge — none on record (asked 2026-10-27)

The Knowledge Hub has no entry for this client, this warehouse or a SQL Server → Databricks
migration, and no live Jira / Confluence source is mounted on it. Not a finding.

## Axis A — type

Primary **1 Migration / modernization** `stated` — driver: the SQL Server licence renewal in
March 2027 (`sources/docs/interview_dba_2026-09-22.md:5`, `sources/docs/kickoff_deck_notes.md:3`).
Secondary signal (not a type change): the nightly window 01:00–05:30 is full and the inventory
snapshot times out at month end (DWH-401) — a performance problem riding on the migration; the
`project-type-cost-performance` module was not loaded, the point is carried as findings.

## Axis B — inputs per source system

| System | Level | In hand (source_id) | Missing to reach next level |
|---|---|---|---|
| SYS-1 Packaging DWH `PACKDWH01\veloxpool` | L2 | DDL 24 tables (src-ddl), 4 procs, 2 views, nightly job, row counts (src-exp-rowcounts), job history (src-exp-jobhist) | sequences, functions, triggers, SQL Agent job definitions, Query Store ≥ 90 days |
| SYS-2 DWH test copy (bore.pub,60747) | L1 | config only (src-cfg) | a read-only sign-in in the Scope step |
| SYS-3 MES (`mes-eu.packaging.local`) | L1 | config + one linked-server query (src-proc-01) | MES table definitions, linked server definition |
| SYS-4 SAP ECC export share (`\\fs01\erp_export`) | L1 | file patterns in the job (src-job-01) | file layouts, sample files, archive policy |
| SYS-5 WMS | L1 | `wms.stock_extract` named in code and spec | the extract's definition and producer |
| SYS-6 QMS web app | L1 | spec, proc header | the app's write paths to `quality.Complaint` |
| SYS-7 LIMS | L1 | spec, one job-history line | the hourly loader's code |
| SYS-8 Power BI · SYS-9 SSRS · SYS-10 sustainability platform | L1 | spec, job history | report definitions (`.rdl`, `.pbix`), execution logs |
| SYS-11 ETL server ETL02 | L1 | job docstring | SQL Agent job export, ETL02 file layout |

## Axis C — decision

> This report is for **Nordic Pack AB's migration sponsor (name: ?) with the DBA (Marta K.)** to
> decide **the wave-1 scope, which business rules are fixed versus carried, and go/no-go on leaving
> SQL Server** before **the licence renewal in March 2027**.  `assumed` — OQ-01

## Blocking questions this turn (≤5)

See `runs/2026-10-27_run-01-member/review.md` › "Needs a human now" — OQ-01, OQ-02, OQ-03, OQ-04, OQ-05.

## Reading order note

The functional spec, the DBA interview and the kickoff notes were read during intake, before the
code. Rules were then written from the code text alone and diffed against the spec's rule table;
every disagreement is recorded as `CONFLICT`, none resolved here.
