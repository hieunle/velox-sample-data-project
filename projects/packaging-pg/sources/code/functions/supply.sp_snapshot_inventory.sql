-- Object: supply.sp_snapshot_inventory
-- Daily at 23:55 from the WMS extract. Owner: Supply chain analytics. Known slow (DWH-401): a full
-- scan of sales.orderline per product for DaysOfCover.
CREATE SEQUENCE IF NOT EXISTS supply.seq_snapshot START 1000001;

CREATE OR REPLACE PROCEDURE supply.sp_snapshot_inventory(p_snapshot_date_key int)
LANGUAGE plpgsql
AS $$
DECLARE
    v_from_key int := to_char(to_date(p_snapshot_date_key::text, 'YYYYMMDD') - 28, 'YYYYMMDD')::int;
BEGIN
    DELETE FROM supply.inventorysnapshot WHERE snapshotdatekey = p_snapshot_date_key;

    INSERT INTO supply.inventorysnapshot
        (snapshotkey, snapshotdatekey, warehousekey, productkey, onhandunits, reservedunits, intransitunits,
         safetystockunits, unitcosteur, stockvalueeur, daysofcover, oldestbatchdate, isblocked, countedat)
    SELECT
        nextval('supply.seq_snapshot'), p_snapshot_date_key, w.warehousekey, s.productkey,
        s.on_hand, s.reserved, s.in_transit, s.safety_stock, s.unit_cost,
        -- Rule R-INV-4: StockValueEur = OnHandUnits x UnitCostEur.
        s.on_hand * s.unit_cost,
        -- Rule R-INV-5: DaysOfCover = OnHand / average daily shipments of the last 28 days (NULL when none shipped).
        CASE WHEN d.avg_daily > 0 THEN s.on_hand / d.avg_daily END,
        s.oldest_batch, s.blocked, s.counted_at
    FROM wms.stock_extract AS s
    JOIN supply.warehouse AS w ON w.warehousecode = s.warehouse_code
    LEFT JOIN LATERAL (
        SELECT SUM(l.quantityshipped) / 28.0 AS avg_daily
        FROM sales.orderline AS l
        WHERE l.productkey = s.productkey
          AND l.orderdatekey BETWEEN v_from_key AND p_snapshot_date_key
    ) AS d ON true;
END;
$$;
