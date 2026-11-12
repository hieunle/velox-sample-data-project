-- Object: mfg.machineevent
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.machineevent (
    eventkey bigint NOT NULL,
    machinekey int NOT NULL,
    eventdatekey int NOT NULL,
    occurredat timestamptz,
    eventtype varchar(30) NOT NULL,
    severity smallint,
    alarmcode varchar(12),
    durationseconds int,
    acknowledgedby varchar(12),
    acknowledgedat timestamp,
    rootcause varchar(60),
    message varchar(400),
    countervalue bigint,
    tempc decimal(5, 1),
    vibrationmms real,
    isplanned boolean,
    shiftstart time,
    sourcesystem varchar(20)
);
