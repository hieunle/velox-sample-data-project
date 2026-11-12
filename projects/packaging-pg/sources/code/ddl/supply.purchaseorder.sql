-- Object: supply.purchaseorder
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE supply.purchaseorder (
    purchaseorderkey bigint NOT NULL,
    ponumber varchar(20) NOT NULL,
    supplierkey int NOT NULL,
    materialkey int NOT NULL,
    plantkey int NOT NULL,
    orderdatekey int NOT NULL,
    orderedat timestamptz,
    expectedon date,
    receivedon date,
    quantity decimal(14, 3) NOT NULL,
    unitofmeasure varchar(5),
    unitprice decimal(19, 4),
    currency char(3),
    totalamount numeric(19, 4),
    status varchar(20),
    buyer varchar(12),
    isframework boolean,
    updatedat timestamp,
    CONSTRAINT pk_purchaseorder PRIMARY KEY (purchaseorderkey)
);
