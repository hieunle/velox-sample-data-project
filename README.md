# velox-sample-data-project

A sample **data project repository** for exercising the Velox Delivery Desktop Databricks
workflow end to end. Nothing here is real client data.

| Path | What it is |
| --- | --- |
| `projects/minhphat-dwh/` | A synthetic SQL Server data warehouse (Minh Phat Retail): DDL, stored procedures, one SSIS package, one SSRS report, usage exports and three documents. Pin **this folder** as the session's Project. |
| `workspaces/` | Ignored by git. Anything put here is local scratch — a session pinned to a folder inside it works in place, with no Workspace panel and no Publish. |

The warehouse is the `minhphat-migration` fixture from `kms-healthcare/velox-skills`
(`databricks-discovery/evals/fixtures/`), without its grader key.
