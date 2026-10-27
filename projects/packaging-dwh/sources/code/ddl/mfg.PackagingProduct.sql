-- Object: mfg.PackagingProduct
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[PackagingProduct]
(
    [ProductKey] INT NOT NULL,
    [Sku] NVARCHAR(20) NOT NULL,
    [ProductName] NVARCHAR(100) NOT NULL,
    [Material] NVARCHAR(30) NULL,
    [PackageType] NVARCHAR(30) NULL,
    [VolumeMl] INT NULL,
    [WeightG] DECIMAL(9, 3) NULL,
    [HeightMm] DECIMAL(7, 1) NULL,
    [WidthMm] DECIMAL(7, 1) NULL,
    [DepthMm] DECIMAL(7, 1) NULL,
    [RecycledContentPct] FLOAT NULL,
    [BarrierLayers] TINYINT NULL,
    [PrintColours] TINYINT NULL,
    [ListPriceEur] DECIMAL(19, 4) NULL,
    [MinOrderQty] INT NULL,
    [LaunchedOn] DATE NULL,
    [DiscontinuedOn] DATE NULL,
    [IsRecyclable] BIT NULL,
    [Description] NVARCHAR(400) NULL,
    [Gtin] CHAR(13) NOT NULL
);
GO

-- No primary key: the load of 2021-03 inserted ProductKey 7 twice and the key was dropped instead of the row (ticket DWH-412).
