-- Object: mfg.energyreading
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.energyreading (
    readingkey bigint NOT NULL,
    plantkey int NOT NULL,
    linekey int NOT NULL,
    readingdatekey int NOT NULL,
    readinghour smallint NOT NULL,
    readat timestamp,
    electricitykwh decimal(12, 3),
    gasm3 decimal(12, 3),
    steamkg decimal(12, 3),
    compressedairm3 decimal(12, 3),
    peakkw decimal(10, 2),
    powerfactor real,
    co2kg decimal(12, 3),
    tariffband varchar(10),
    isestimated boolean
);
