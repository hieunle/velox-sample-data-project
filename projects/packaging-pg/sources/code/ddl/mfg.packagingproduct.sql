-- Object: mfg.packagingproduct
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.packagingproduct (
    productkey int NOT NULL,
    sku varchar(20) NOT NULL,
    productname varchar(100) NOT NULL,
    material varchar(30),
    packagetype varchar(30),
    volumeml int,
    weightg decimal(9, 3),
    heightmm decimal(7, 1),
    widthmm decimal(7, 1),
    depthmm decimal(7, 1),
    recycledcontentpct double precision,
    barrierlayers smallint,
    printcolours smallint,
    listpriceeur decimal(19, 4),
    minorderqty int,
    launchedon date,
    discontinuedon date,
    isrecyclable boolean,
    description varchar(400),
    gtin char(13) NOT NULL
);

-- No primary key: the load of 2021-03 inserted productkey 7 twice and the key was dropped instead of the row (ticket DWH-412).
