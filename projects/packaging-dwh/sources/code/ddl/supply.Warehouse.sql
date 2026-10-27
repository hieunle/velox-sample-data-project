-- Object: supply.Warehouse
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [supply].[Warehouse]
(
    [WarehouseKey] INT NOT NULL,
    [WarehouseCode] NVARCHAR(10) NOT NULL,
    [PlantKey] INT NOT NULL,
    [WarehouseType] NVARCHAR(30) NULL,
    [PalletPositions] INT NULL,
    [IsTemperatureControlled] BIT NULL,
    [MinTempC] DECIMAL(4, 1) NULL,
    [MaxTempC] DECIMAL(4, 1) NULL,
    [OpenedOn] DATE NULL,
    [ManagerName] NVARCHAR(80) NULL
);
GO
