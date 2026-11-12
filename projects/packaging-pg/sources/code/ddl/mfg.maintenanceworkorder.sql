-- Object: mfg.maintenanceworkorder
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.maintenanceworkorder (
    workorderkey int NOT NULL,
    workordernumber varchar(20) NOT NULL,
    machinekey int NOT NULL,
    worktype varchar(30),
    priority smallint,
    status varchar(20),
    reportedat timestamptz,
    startedat timestamp,
    completedat timestamp,
    plannedhours decimal(6, 2),
    actualhours decimal(6, 2),
    labourcosteur numeric(19, 4),
    partscosteur numeric(19, 4),
    technician varchar(12),
    failuremode varchar(60),
    sparepartcode varchar(20),
    downtimeminutes int,
    safetyrelated boolean,
    description varchar(400),
    externalid uuid
);
