-- Object: sales.pricelist
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE sales.pricelist (
    pricekey int NOT NULL,
    productkey int NOT NULL,
    customerkey int,
    currency char(3) NOT NULL,
    unitprice decimal(19, 4) NOT NULL,
    minquantity int,
    validfrom date NOT NULL,
    validto date,
    pricetype varchar(20),
    approvedby varchar(40),
    approvedat timestamp,
    isactive boolean
);
