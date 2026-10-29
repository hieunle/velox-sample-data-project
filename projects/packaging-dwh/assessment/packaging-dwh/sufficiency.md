# Evidence sufficiency — packaging-dwh  (run-01, 2026-10-27)

Decision served (assumed, OQ-01): wave-1 scope, fix-or-carry per rule, go/no-go before March 2027.

| Conclusion needed | Evidence required | In hand | State | If missing |
|---|---|---|---|---|
| Which systems feed and read the warehouse | Code, config, docs naming each system | 11 systems from config, code, spec, job history (`source_systems.jsonl`) | ✅ | — |
| Inventory of tables and code | Full object scripts | 24 tables, 4 procs, 2 views, 1 job; sequences, SSIS, Agent jobs and loaders missing | ⚠️ | Wave plan may miss feeds (FND-05) |
| Business rules and conflicts with the spec | Code of every transform + spec | 4 procs, 2 views diffed against the spec's rule table: 28 rules, 3 CONFLICT, 3 DOC-ONLY | ⚠️ | Rules in SSIS, loaders, Power BI and SSRS not read |
| Real job graph and critical path | Agent job definitions + ≥ 90 days of history | One run per step; two possible callers of each proc | ❌ | Target job graph cannot be drawn (FND-01) |
| Which objects can be retired | Usage ≥ 90 days incl. month-end and quarter-end | DMV last-read dates, window unknown | ❌ | Nothing may be called orphan; no retire list |
| Volume, backfill and sizing | Production row counts and sizes | Test-copy counts capped at 10,000 rows | ❌ | No volume or compute estimate (FND-15) |
| Effort | Complexity per object + trial transpile rate | None; Analyzer not run (no workspace) | ❌ | Effort drivers only, no range |
| Wave order and pilot | Sponsor decision + dependency graph | Graph from code (42 edges); kickoff and DBA disagree | ⚠️ | Pilot open until OQ-02 |
| Reconciliation design | Acceptance criteria + type and time-zone behaviour | Kickoff criteria, DBA pitfalls, code behaviour | ⚠️ | Tolerance and currency open (OQ-12, OQ-15) |
| Security posture | SAT run or workspace | Infrastructure code only: config and job | ❌ not scored | Security readiness stays unscored; workspace is the first open item |
| **Usage window** | Log source, start, end, last restart | Source: `table_rowcounts.csv` (index-usage DMV columns `last_user_read`/`last_user_write`); start: unknown; end: 2026-09-30; last restart: unknown. Job history: one sample per step, 2026-08-31 to 2026-09-29 | ❌ | Request R5, R6 |
