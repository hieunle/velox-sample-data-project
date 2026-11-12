-- Object: quality.inspection
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE quality.inspection (
    inspectionid bigint NOT NULL,
    batchcode varchar(20) NOT NULL,
    productionrunkey bigint NOT NULL,
    plantkey int,
    checktype varchar(30) NOT NULL,
    samplesize smallint,
    passed boolean NOT NULL,
    defectcode varchar(10),
    measuredvalue decimal(10, 4),
    lowerlimit decimal(10, 4),
    upperlimit decimal(10, 4),
    inspectedat timestamp,
    inspector varchar(12),
    instrument varchar(40),
    comment varchar(400),
    shiftstart time
);
