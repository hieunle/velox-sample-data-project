# Kickoff — Databricks migration of the Packaging DWH (notes, 2026-09-15)

- Goal: the warehouse on Databricks (Unity Catalog, Delta) before the SQL Server licence renewal in March 2027.
- Wave 1: `mfg` (production runs, machine events, energy) and the OEE dataset. Wave 2: `sales` and
  `supply`. Wave 3: `quality`, after the QMS app stops writing to the warehouse.
- Acceptance: every business rule in the functional spec holds on the migrated tables; row counts
  and the sums of `UnitsProduced`, `NetAmount`, `GrossAmount`, `StockValueEur` match the source for
  the same date; the duplicate in `mfg.PackagingProduct` is resolved, not copied.
- Out of scope: Power BI model rewrite (separate project), SSRS retirement.
- Risks named in the room: three time zones in `datetimeoffset` columns, case-sensitive batch codes,
  the QMS app writing to `quality.Complaint`, 40-minute inventory snapshot.
