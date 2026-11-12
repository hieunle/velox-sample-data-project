-- Object: mfg.vw_dailyoee
-- Powers the Power BI dataset "Plant performance" (refresh 06:00). Owner: Operations BI.
CREATE OR REPLACE VIEW mfg.vw_dailyoee AS
SELECT
    p.plantcode, p.plantname, l.linecode, r.productiondatekey,
    SUM(r.unitsproduced) AS unitsproduced,
    SUM(r.unitsrejected) AS unitsrejected,
    -- Rule R-OEE-3: the daily OEE of a line is weighted by DurationMinutes, never a plain average.
    SUM(r.oee * r.durationminutes) / NULLIF(SUM(r.durationminutes), 0) AS oee,
    SUM(r.energykwh) / NULLIF(SUM(r.unitsproduced), 0) * 1000 AS kwhperthousandunits
FROM mfg.productionrun AS r
JOIN mfg.productionline AS l ON l.linekey = r.linekey
JOIN mfg.plant AS p ON p.plantkey = r.plantkey
GROUP BY p.plantcode, p.plantname, l.linecode, r.productiondatekey;
