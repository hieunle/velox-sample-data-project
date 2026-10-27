-- Object: mfg.vw_DailyOee
-- Powers the Power BI dataset "Plant performance" (refresh 06:00). Owner: Operations BI.
CREATE OR ALTER VIEW [mfg].[vw_DailyOee]
AS
SELECT
    p.PlantCode, p.PlantName, l.LineCode, r.ProductionDateKey,
    SUM(r.UnitsProduced) AS UnitsProduced,
    SUM(r.UnitsRejected) AS UnitsRejected,
    -- Rule R-OEE-3: the daily OEE of a line is weighted by DurationMinutes, never a plain average.
    SUM(r.Oee * r.DurationMinutes) / NULLIF(SUM(r.DurationMinutes), 0) AS Oee,
    SUM(r.EnergyKwh) / NULLIF(SUM(r.UnitsProduced), 0) * 1000 AS KwhPerThousandUnits
FROM mfg.ProductionRun AS r
JOIN mfg.ProductionLine AS l ON l.LineKey = r.LineKey
JOIN mfg.Plant AS p ON p.PlantKey = r.PlantKey
GROUP BY p.PlantCode, p.PlantName, l.LineCode, r.ProductionDateKey;
GO
