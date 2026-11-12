-- Object: supply.shipment
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE supply.shipment (
    shipmentkey bigint NOT NULL,
    shipmentnumber varchar(20) NOT NULL,
    salesorderkey bigint NOT NULL,
    customerkey int NOT NULL,
    sitekey int NOT NULL,
    warehousekey int NOT NULL,
    shipdatekey int NOT NULL,
    shippedat timestamptz,
    deliveredat timestamptz,
    carrier varchar(40),
    transportmode varchar(10),
    pallets smallint,
    grossweightkg decimal(12, 2),
    freightcosteur numeric(19, 4),
    co2kg decimal(10, 2),
    trackingnumber varchar(30),
    status varchar(20),
    delayminutes int,
    temperaturelogged boolean,
    updatedat timestamp,
    CONSTRAINT pk_shipment PRIMARY KEY (shipmentkey, shipdatekey)
);
