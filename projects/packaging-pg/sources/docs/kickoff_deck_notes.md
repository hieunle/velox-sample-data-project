# Kickoff — Databricks migration of the Packaging DWH (notes, 2026-09-15)

- Goal: the warehouse on Databricks (Unity Catalog, Delta) before the hardware lease of `packdwh-pg01` ends in March 2027.
- Wave 1: `mfg` (production runs, machine events, energy) and the OEE dataset. Wave 2: `sales` and
  `supply`. Wave 3: `quality`, after the QMS app stops writing to the warehouse.
- Acceptance: every business rule in the functional spec holds on the migrated tables; row counts
  and the sums of `unitsproduced`, `netamount`, `grossamount`, `stockvalueeur` match the source for
  the same date; the duplicate in `mfg.packagingproduct` is resolved, not copied.
- Out of scope: Power BI model rewrite (separate project), Metabase retirement.
- Risks named in the room: plant-local time lost in `timestamptz` columns, case-variant e-mails in
  `sales.customer`, the QMS app writing to `quality.complaint`, 40-minute inventory snapshot.
