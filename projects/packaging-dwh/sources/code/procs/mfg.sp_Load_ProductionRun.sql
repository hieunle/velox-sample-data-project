-- Object: mfg.sp_Load_ProductionRun
-- Nightly at 01:30 (SQL Agent job DWH_Nightly, step 2). Pulls yesterday's runs from the MES
-- (linked server MES_EU) and recomputes OEE. Owner: DWH team. Last change 2024-11-03 (DWH-388).
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE [mfg].[sp_Load_ProductionRun]
    @LoadDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @LoadDate IS NULL SET @LoadDate = DATEADD(day, -1, CAST(SYSDATETIME() AS DATE));
    DECLARE @DateKey INT = CAST(CONVERT(CHAR(8), @LoadDate, 112) AS INT);

    -- Idempotent: a rerun replaces the day.
    DELETE FROM mfg.ProductionRun WHERE ProductionDateKey = @DateKey;

    INSERT INTO mfg.ProductionRun
        (ProductionRunKey, MachineKey, LineKey, PlantKey, ProductKey, ProductionDateKey, ShiftStart, StartedAt,
         DurationMinutes, BatchCode, UnitsPlanned, UnitsProduced, UnitsRejected, ScrapKg, EnergyKwh, WaterLitres,
         Oee, Availability, Performance, QualityRate)
    SELECT
        r.run_id, m.MachineKey, m.LineKey, m.PlantKey, p.ProductKey, @DateKey, r.shift_start, r.started_at,
        r.duration_min, r.batch_code, r.units_planned, r.units_good + r.units_rejected, r.units_rejected,
        r.scrap_kg, r.energy_kwh, r.water_l,
        -- Rule R-OEE-1: OEE = Availability x Performance x Quality, each in [0, 1].
        r.availability * r.performance * r.quality,
        r.availability, r.performance, r.quality
    FROM MES_EU.mes.dbo.production_run AS r
    JOIN mfg.Machine AS m ON m.ExternalId = r.machine_ext_id
    JOIN mfg.PackagingProduct AS p ON p.Sku = r.sku
    WHERE CAST(r.started_at AS DATE) = @LoadDate;

    -- Rule R-OEE-2: rejected units never exceed produced units.
    IF EXISTS (SELECT 1 FROM mfg.ProductionRun WHERE ProductionDateKey = @DateKey AND UnitsRejected > UnitsProduced)
        THROW 51001, 'ProductionRun: UnitsRejected > UnitsProduced for the load date', 1;
END;
GO
