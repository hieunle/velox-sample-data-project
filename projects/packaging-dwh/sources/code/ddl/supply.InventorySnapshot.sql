-- Object: supply.InventorySnapshot
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [supply].[InventorySnapshot]
(
    [SnapshotKey] BIGINT NOT NULL,
    [SnapshotDateKey] INT NOT NULL,
    [WarehouseKey] INT NOT NULL,
    [ProductKey] INT NOT NULL,
    [OnHandUnits] BIGINT NOT NULL,
    [ReservedUnits] BIGINT NULL,
    [InTransitUnits] BIGINT NULL,
    [SafetyStockUnits] BIGINT NULL,
    [UnitCostEur] DECIMAL(19, 4) NULL,
    [StockValueEur] MONEY NULL,
    [DaysOfCover] DECIMAL(7, 1) NULL,
    [OldestBatchDate] DATE NULL,
    [IsBlocked] BIT NULL,
    [CountedAt] DATETIME2 NULL
);
GO
