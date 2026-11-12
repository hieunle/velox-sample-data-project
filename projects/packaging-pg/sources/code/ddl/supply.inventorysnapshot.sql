-- Object: supply.inventorysnapshot
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE supply.inventorysnapshot (
    snapshotkey bigint NOT NULL,
    snapshotdatekey int NOT NULL,
    warehousekey int NOT NULL,
    productkey int NOT NULL,
    onhandunits bigint NOT NULL,
    reservedunits bigint,
    intransitunits bigint,
    safetystockunits bigint,
    unitcosteur decimal(19, 4),
    stockvalueeur numeric(19, 4),
    daysofcover decimal(7, 1),
    oldestbatchdate date,
    isblocked boolean,
    countedat timestamp
);
