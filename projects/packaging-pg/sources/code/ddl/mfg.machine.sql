-- Object: mfg.machine
-- Scripted from packdwh-pg01/veloxpool by pg_dump --schema-only, 2026-09-30
CREATE TABLE mfg.machine (
    machinekey int NOT NULL,
    linekey int NOT NULL,
    plantkey int NOT NULL,
    machinetype varchar(40),
    model varchar(40),
    serialnumber varchar(30) NOT NULL,
    manufacturer varchar(60),
    installedon date,
    warrantyuntil date,
    nominalunitsperhour int,
    powerkw decimal(8, 2),
    weightkg decimal(10, 1),
    firmwareversion varchar(20),
    externalid uuid NOT NULL,
    iscritical boolean,
    lastserviceat timestamp
);
