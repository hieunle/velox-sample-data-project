-- Object: quality.complaint
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE quality.complaint (
    complaintkey int NOT NULL,
    complaintnumber varchar(20) NOT NULL,
    customerkey int NOT NULL,
    productkey int NOT NULL,
    batchcode varchar(20),
    receivedat timestamptz,
    category varchar(40),
    severity smallint,
    status varchar(20),
    closedon date,
    unitsaffected int,
    creditnoteamount numeric(19, 4),
    rootcause varchar(200),
    description varchar(400),
    owner varchar(12),
    isrecall boolean
);
