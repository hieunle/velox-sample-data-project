-- Object: sales.invoice
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE sales.invoice (
    invoicekey bigint NOT NULL,
    invoicenumber varchar(20) NOT NULL,
    salesorderkey bigint NOT NULL,
    customerkey int NOT NULL,
    invoicedatekey int NOT NULL,
    issuedat timestamptz,
    duedate date,
    paidon date,
    currency char(3),
    netamount numeric(19, 4) NOT NULL,
    taxamount numeric(19, 4),
    grossamount numeric(19, 4),
    exchangerate decimal(12, 6),
    paymentmethod varchar(20),
    dunninglevel smallint,
    iscreditnote boolean,
    reference varchar(40),
    updatedat timestamp,
    CONSTRAINT pk_invoice PRIMARY KEY (invoicekey)
);
