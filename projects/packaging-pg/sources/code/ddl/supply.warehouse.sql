-- Object: supply.warehouse
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE supply.warehouse (
    warehousekey int NOT NULL,
    warehousecode varchar(10) NOT NULL,
    plantkey int NOT NULL,
    warehousetype varchar(30),
    palletpositions int,
    istemperaturecontrolled boolean,
    mintempc decimal(4, 1),
    maxtempc decimal(4, 1),
    openedon date,
    managername varchar(80)
);
