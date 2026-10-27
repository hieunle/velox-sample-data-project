## decision

Nordic Pack AB can start the move off SQL Server now, but it cannot yet commit to a wave plan or an estimate. The code and documents show a small, readable warehouse: 24 tables, four procedures and two views carry the business rules, and most of the spec's rules match the code. Three rules do not, and they sit on numbers the business signs off on: days of cover in the inventory snapshot, the root-cause check when a complaint closes, and the 0–1 bound on OEE factors.

Three decisions cannot be made from the evidence in hand. First, what can be retired, because there is no 90-day usage log. Second, how big the move is, because the row counts come from a copy loaded at demo size, while production holds a 2 TB data file. Third, what the nightly job graph really is, because both SQL Agent and the Python loader call the same procedures.

Recommendation: confirm wave 1 and the pilot with the sponsor and the DBA this month, since kickoff and DBA disagree. Request the production usage log, job definitions and missing loaders now, because they are the longest lead items. Waiting past November leaves under four months to build, reconcile and cut over before the March 2027 renewal.

## architecture

Domain-level outline; object names stay placeholders until agreed.

- **Catalogs and schemas.** One catalog per environment, with one schema per subject area (`mfg`, `sales`, `supply`, `quality`) in each medallion layer. Alternatively, use bronze, silver and gold schemas inside a single `<catalog>`. The trade-off is governance by domain against simpler grants by layer. That choice is the architect's.
- **Ingestion.** MES production runs move from the linked server to Lakeflow Connect for SQL Server, or to Lakehouse Federation during transition. The SAP flat files move to a cloud landing zone read by Auto Loader, which tracks files and replaces the bcp append. The WMS stock extract and the LIMS hourly feed need their producers found before a pattern is chosen.
- **Silver.** Conform keys here. Fix the duplicate product before anything joins on it. Keep case-sensitive batch codes, and set a collation policy for the rest. Store each timestamp as a UTC instant plus the plant-local date. Pipeline expectations carry the reject check, with the day rolled back on failure, and the uniqueness rules.
- **Gold and metric views.** Daily OEE, energy per thousand units, open receivables and dunning levels become Unity Catalog metric views. Power BI and SSRS repoint to Databricks SQL.
- **Orchestration.** One Lakeflow Job replaces SQL Agent and the ETL server. The inventory snapshot is redesigned to compute 28-day demand once per product and day, so it no longer runs per stock row.
- **Keys.** Existing IDENTITY and sequence values load as data. New values come from a controlled generator, so SAP-facing customer, supplier and invoice numbers do not change.
- **Security.** Each consumer gets its own service principal or group, matching today's one login per consumer. Contact and staff columns get tags and masks. Secrets move to a secret scope. The test copy is reached over a private path, not a public tunnel.

## roadmap

- **Phase 0, now to end of November 2026: close the evidence gaps.** Gather the production usage log of 90 days or more, the SQL Agent jobs, the sequences, SSIS and the missing loaders. Re-export the DDL. Settle the pilot, days of cover, time zones and product 7. Exit criterion: a sufficiency table with no ❌ on scope and volume.
- **Phase 1, wave 1: manufacturing and the daily OEE dataset (pilot).** Exit criterion: daily OEE and units produced reconcile per line and day at a pinned cut-off.
- **Phase 2, wave 2: sales and supply.** This covers invoices, open receivables and the inventory snapshot, with the snapshot redesigned. Exit criterion: net, gross and stock value reconcile per currency and date, and the dunning list matches.
- **Phase 3, wave 3: quality.** It starts only after the QMS app stops writing complaints into the warehouse. Exit criterion: complaint and lab tables are read-only on SQL Server.
- **Cut-over before March 2027.** Run in parallel through one month-end, then switch off SQL Server.

## drivers

These are estimate drivers, not a price. Every driver comes from code and documents only, so each is a guess until the missing sources arrive.

- **Objects found.** The folder holds 24 tables, 2 sequences, 4 procedures, 2 views, 1 Python loader and 2 SQL Agent jobs. It also names 4 consumers, 1 application and 1 export. Loaders, SSIS and report definitions are still missing.
- **Rules.** The run found 28 rules, of which 3 are in conflict and 3 exist only in the spec. Conflicts cost calendar time with owners, not build effort.
- **Re-architecture.** The inventory snapshot, the key generation and the time-zone design need redesign.
- **Not measured.** There is no complexity score and no trial transpile rate, because Lakebridge was not run. Production volume and backfill depth are also unknown.

## risks

- **Volume unknown.** Every size or cost figure today would come from a demo-sized copy. Mitigation: get production row counts in Phase 0. Owner: the DBA.
- **Days of cover and complaint closure disagree with the spec.** Reconciliation against the spec fails either way. Mitigation: owner decisions before wave 2 and wave 3.
- **Time zones.** Plant-local days can shift when timestamps convert to UTC, which breaks daily reconciliation. Mitigation: settle the day boundary and the hidden Power BI conversion before the wave-1 schema.
- **The duplicate product may inflate production.** Fixing it on the target then breaks the units-produced match. Mitigation: count the duplicate's SKUs on the test copy, then reconcile with and without it.
- **Logic in Power BI is out of scope.** The model's UTC conversion and de-duplication stay hidden. Mitigation: capture both before repointing.
- **Test copy on a public tunnel.** The copy is reachable from the internet without certificate checks. Mitigation: move it to a private path before Federation reads it.
