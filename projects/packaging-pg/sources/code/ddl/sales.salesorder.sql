-- Object: sales.salesorder
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE sales.salesorder (
    salesorderkey bigint NOT NULL,
    ordernumber varchar(20) NOT NULL,
    customerkey int NOT NULL,
    sitekey int NOT NULL,
    orderdatekey int NOT NULL,
    orderedat timestamptz,
    requesteddelivery date,
    promiseddelivery date,
    channel varchar(20),
    status varchar(20) NOT NULL,
    currency char(3),
    ordertotal numeric(19, 4),
    freightcost numeric(10, 4),
    incoterm char(3),
    salesrep varchar(12),
    purchaseorderref varchar(30),
    isrush boolean,
    createdby varchar(40),
    updatedat timestamp,
    comment varchar(400),
    CONSTRAINT pk_salesorder PRIMARY KEY (salesorderkey)
);
