-- Object: mfg.material
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.material (
    materialkey int NOT NULL,
    materialcode varchar(20) NOT NULL,
    materialname varchar(80),
    category varchar(30),
    unitofmeasure varchar(5),
    gramsperm2 decimal(9, 2),
    renewablecontentpct double precision,
    standardcosteur numeric(10, 4),
    foodcontactapproved boolean,
    approvedon date,
    shelflifedays smallint,
    hazardclass varchar(10)
);
