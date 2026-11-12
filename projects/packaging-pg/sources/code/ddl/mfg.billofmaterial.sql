-- Object: mfg.billofmaterial
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.billofmaterial (
    bomlinekey int NOT NULL,
    productkey int NOT NULL,
    materialkey int NOT NULL,
    quantityperthousand decimal(12, 4),
    unitofmeasure varchar(5),
    scrapallowancepct double precision,
    validfrom date,
    validto date,
    revision smallint,
    isalternative boolean
);
