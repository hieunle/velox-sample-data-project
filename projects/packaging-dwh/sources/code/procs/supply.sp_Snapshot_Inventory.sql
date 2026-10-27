-- Object: supply.sp_Snapshot_Inventory
-- Daily at 23:55 from the WMS extract. Owner: Supply chain analytics. Known slow (DWH-401): a full
-- scan of supply.InventorySnapshot for DaysOfCover.
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE [supply].[sp_Snapshot_Inventory]
    @SnapshotDateKey INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM supply.InventorySnapshot WHERE SnapshotDateKey = @SnapshotDateKey;

    INSERT INTO supply.InventorySnapshot
        (SnapshotKey, SnapshotDateKey, WarehouseKey, ProductKey, OnHandUnits, ReservedUnits, InTransitUnits,
         SafetyStockUnits, UnitCostEur, StockValueEur, DaysOfCover, OldestBatchDate, IsBlocked, CountedAt)
    SELECT
        NEXT VALUE FOR supply.seq_Snapshot, @SnapshotDateKey, w.WarehouseKey, s.ProductKey,
        s.on_hand, s.reserved, s.in_transit, s.safety_stock, s.unit_cost,
        -- Rule R-INV-4: StockValueEur = OnHandUnits x UnitCostEur.
        s.on_hand * s.unit_cost,
        -- Rule R-INV-5: DaysOfCover = OnHand / average daily shipments of the last 28 days (NULL when none shipped).
        CASE WHEN d.avg_daily > 0 THEN s.on_hand / d.avg_daily END,
        s.oldest_batch, s.blocked, s.counted_at
    FROM wms.stock_extract AS s
    JOIN supply.Warehouse AS w ON w.WarehouseCode = s.warehouse_code
    OUTER APPLY (
        SELECT SUM(l.QuantityShipped) / 28.0 AS avg_daily
        FROM sales.OrderLine AS l
        WHERE l.ProductKey = s.ProductKey
          AND l.OrderDateKey BETWEEN CAST(CONVERT(CHAR(8), DATEADD(day, -28, CONVERT(DATE, CAST(@SnapshotDateKey AS CHAR(8)), 112)), 112) AS INT) AND @SnapshotDateKey
    ) AS d;
END;
GO
