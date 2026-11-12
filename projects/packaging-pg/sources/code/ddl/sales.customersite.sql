-- Object: sales.customersite
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE sales.customersite (
    sitekey int NOT NULL,
    customerkey int NOT NULL,
    sitecode varchar(14) NOT NULL,
    sitetype varchar(20),
    addressline varchar(120),
    city varchar(60),
    country varchar(40),
    latitude decimal(9, 6),
    longitude decimal(9, 6),
    dockdoors smallint,
    openingtime time,
    closingtime time,
    isactive boolean,
    deliveryinstructions varchar(400)
);
