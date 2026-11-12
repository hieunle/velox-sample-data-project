-- Object: mfg.sp_load_productionrun
-- Nightly at 01:30 (pg_cron job dwh_nightly, step 2). Pulls yesterday's runs from the MES
-- (postgres_fdw foreign schema mes_eu) and recomputes OEE. Owner: DWH team. Last change 2024-11-03 (DWH-388).
CREATE OR REPLACE PROCEDURE mfg.sp_load_productionrun(p_load_date date DEFAULT NULL)
LANGUAGE plpgsql
AS $$
DECLARE
    v_load_date date := COALESCE(p_load_date, current_date - 1);
    v_date_key  int  := to_char(v_load_date, 'YYYYMMDD')::int;
BEGIN
    -- Idempotent: a rerun replaces the day.
    DELETE FROM mfg.productionrun WHERE productiondatekey = v_date_key;

    INSERT INTO mfg.productionrun
        (productionrunkey, machinekey, linekey, plantkey, productkey, productiondatekey, shiftstart, startedat,
         durationminutes, batchcode, unitsplanned, unitsproduced, unitsrejected, scrapkg, energykwh, waterlitres,
         oee, availability, performance, qualityrate)
    SELECT
        r.run_id, m.machinekey, m.linekey, m.plantkey, p.productkey, v_date_key, r.shift_start, r.started_at,
        r.duration_min, r.batch_code, r.units_planned, r.units_good + r.units_rejected, r.units_rejected,
        r.scrap_kg, r.energy_kwh, r.water_l,
        -- Rule R-OEE-1: OEE = Availability x Performance x Quality, each in [0, 1].
        r.availability * r.performance * r.quality,
        r.availability, r.performance, r.quality
    FROM mes_eu.production_run AS r
    JOIN mfg.machine AS m ON m.externalid = r.machine_ext_id
    JOIN mfg.packagingproduct AS p ON p.sku = r.sku
    WHERE r.started_at::date = v_load_date;

    -- Rule R-OEE-2: rejected units never exceed produced units.
    IF EXISTS (SELECT 1 FROM mfg.productionrun WHERE productiondatekey = v_date_key AND unitsrejected > unitsproduced) THEN
        RAISE EXCEPTION 'productionrun: unitsrejected > unitsproduced for the load date' USING ERRCODE = 'P0001';
    END IF;
END;
$$;
