-- Object: sales.orderline
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE sales.orderline (
    orderlinekey bigint NOT NULL,
    salesorderkey bigint NOT NULL,
    ordernumber varchar(20) NOT NULL,
    linenumber smallint NOT NULL,
    customerkey int NOT NULL,
    productkey int NOT NULL,
    plantkey int NOT NULL,
    orderdatekey int NOT NULL,
    requesteddelivery date,
    quantity int NOT NULL,
    quantityshipped int,
    unitprice decimal(19, 4) NOT NULL,
    discountpct double precision,
    lineamount numeric(19, 4),
    taxamount numeric(19, 4),
    currency char(3),
    printdesigncode varchar(20),
    palletcount smallint,
    orderedat timestamptz,
    linestatus varchar(20),
    issample boolean,
    updatedat timestamp,
    CONSTRAINT pk_orderline PRIMARY KEY (orderlinekey)
);
