# packaging-dwh — Nordic Pack AB warehouse (synthetic)

A synthetic SQL Server data warehouse of a packaging manufacturer, built to exercise the Velox
Databricks workflow end to end: **Assess** reads this folder, **Migration** reads the live copy
through Lakehouse Federation. Nothing here is real data.

The live copy is the 24-table dataset from `kms-healthcare/velox-databricks-app`
`scripts/synapse_packaging_data.py` (the set Addepto uses on Synapse), ported to plain SQL Server
and loaded at the demo size (`--max-rows 10000`, 158,709 rows). Its host and port are in
`config/connections.ini`; the password of `velox_reader` is never in this folder.

| Path | What it is |
| --- | --- |
| `sources/code/ddl/` | One file per table, 24 tables in `mfg`, `sales`, `supply`, `quality` |
| `sources/code/procs/`, `views/` | Four procedures and two views that carry the business rules (R-OEE-*, R-INV-*, R-CMP-1) |
| `sources/code/jobs/dwh_nightly.py` | The nightly load; reads `config/connections.ini` |
| `sources/docs/` | Functional spec with the rule table and open tickets, a DBA interview, kickoff notes |
| `sources/exports/` | Row counts and sizes from the live copy, 90 days of job history |

Pin **this folder** as the session's Project.
