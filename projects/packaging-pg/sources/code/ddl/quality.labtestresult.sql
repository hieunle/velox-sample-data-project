-- Object: quality.labtestresult
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE quality.labtestresult (
    testkey bigint NOT NULL,
    samplecode varchar(20) NOT NULL,
    materialkey int NOT NULL,
    purchaseorderkey bigint,
    testdatekey int NOT NULL,
    testedat timestamp,
    method varchar(40),
    resultvalue decimal(12, 4),
    unit varchar(10),
    specmin decimal(12, 4),
    specmax decimal(12, 4),
    withinspec boolean NOT NULL,
    uncertainty real,
    analyst varchar(12),
    instrument varchar(40),
    approvedby varchar(12),
    approvedat timestamptz,
    sampletime time,
    externallabid uuid,
    comment varchar(400)
);
