-- Object: mfg.productionline
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.productionline (
    linekey int NOT NULL,
    plantkey int NOT NULL,
    linecode varchar(10) NOT NULL,
    linetype varchar(40),
    shifts smallint,
    commissionedon date,
    nominalpacksperhour int,
    targetoee double precision,
    supervisor varchar(80),
    isactive boolean,
    lastauditon date,
    notes varchar(400)
);
