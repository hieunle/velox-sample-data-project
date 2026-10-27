# Review — packaging-dwh run-01 (2026-10-27, member)

Approach: **without a workspace**, so the run read code and documents only. Skills used were `discovery-intake`, `legacy-etl-archaeology` and `requirements-extraction`. The draft report was built with `assessment-synthesis`. The Knowledge Hub was asked and had nothing on record.

## Read, in order

1. **Intake.** The README, the kickoff notes, the DBA interview, the functional spec and `config/connections.ini`. The documents were read before the code during intake.
2. **Code.** Rules were then written from the code text alone: 4 procedures, 2 views and `jobs/dwh_nightly.py`.
3. **Remaining evidence.** The DDL for 24 tables, plus `exports/table_rowcounts.csv` and `exports/sysjobhistory_90d.csv`.
4. **Diff.** The rules were diffed against the spec's rule table, the interview and the kickoff.

## Produced

| Register | Records |
|---|---|
| source_systems | 11 |
| inventory | 48 |
| business_rules | 28 |
| requirements | 36 |
| findings | 26 (8 high, 16 medium, 2 low) |
| dependency_edges | 42 |
| open_questions | 17 |

`rationalization` and `readiness` were not written. With no usage log and no volume, every object would be `defer`, and security cannot be scored without a workspace.

## Needs a human now (≤ 5)

1. **OQ-01, the decision and the sponsor.** Accept or edit the sentence in `intake.md`.
2. **OQ-02, wave 1 and the pilot.** The kickoff wants manufacturing and OEE first. The DBA wants the hot fact tables and receivables first.
3. **OQ-03, days of cover.** The code and the spec disagree on window, date basis and scope.
4. **OQ-04, the production-day time zone** and where Power BI converts to UTC.
5. **OQ-05, who runs the procedures.** Both SQL Agent and the Python loader call them.

## rule_status distribution

| VERIFIED | CONFLICT | CODE-ONLY | DOC-ONLY | CONFIG-ONLY | DEAD | UNRESOLVED |
|---|---|---|---|---|---|---|
| 9 | 3 | 13 | 3 | 0 | 0 | 0 |

The three conflicts are BR-001 (OEE bound), BR-019 (days of cover) and BR-024 (complaint root cause).

## Unsure (confidence low or medium on judgement)

- **FND-03, low.** It is inferred that the duplicate product doubles production runs. One count on the test copy settles it.
- **FND-01, medium.** Two callers of each procedure are stated. Whether both actually fire is not shown.
- **SYS-3, MES database name.** The config says MES_PROD, but the procedure reads a catalog named `mes`.

## What was run, and what stayed unreproduced

Nothing was executed against client data or the test copy. The only commands were file reads and the pack's `write_records.py`. Every behaviour claim is `stated` from code, and none is `reproduced`. FND-03, FND-09 and FND-04 could each be reproduced with one read-only query on the test copy. That needs the person's sign-in in Scope.

## Deliberately not concluded

- **Retirement.** Nothing is marked orphan or retire, because no usage window of 90 days or more exists.
- **Volume and sizing.** There is no volume, backfill or compute sizing, because the row counts come from the demo-sized copy.
- **Effort.** There is no complexity score and no effort range, because Lakebridge Analyzer was not run.
- **Security posture.** Security is not scored. Findings come from config and job code only.
- **Unread code.** Rules inside SSIS, the missing loaders, Power BI models and SSRS reports were not read.

## How to merge

Review each record in Velox's Assess step, or in the Workspace panel's Review tab. Decisions land in `assessment/packaging-dwh/registers/`. When done, say "regenerate" to build the final report from the reviewed registers only.
