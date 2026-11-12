-- Object: mfg.plant
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.plant (
    plantkey int NOT NULL,
    plantcode char(6) NOT NULL,
    plantname varchar(80) NOT NULL,
    country varchar(40),
    region varchar(20),
    city varchar(60),
    openedon date,
    flooraream2 int,
    employees smallint,
    annualcapacitymillionpacks decimal(9, 1),
    isocertified boolean,
    timezone varchar(10),
    latitude decimal(9, 6),
    longitude decimal(9, 6)
);
