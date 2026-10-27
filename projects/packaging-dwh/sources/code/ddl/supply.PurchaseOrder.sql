-- Object: supply.PurchaseOrder
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [supply].[PurchaseOrder]
(
    [PurchaseOrderKey] BIGINT NOT NULL,
    [PoNumber] NVARCHAR(20) NOT NULL,
    [SupplierKey] INT NOT NULL,
    [MaterialKey] INT NOT NULL,
    [PlantKey] INT NOT NULL,
    [OrderDateKey] INT NOT NULL,
    [OrderedAt] DATETIMEOFFSET NULL,
    [ExpectedOn] DATE NULL,
    [ReceivedOn] DATE NULL,
    [Quantity] DECIMAL(14, 3) NOT NULL,
    [UnitOfMeasure] VARCHAR(5) NULL,
    [UnitPrice] DECIMAL(19, 4) NULL,
    [Currency] CHAR(3) NULL,
    [TotalAmount] MONEY NULL,
    [Status] NVARCHAR(20) NULL,
    [Buyer] NVARCHAR(12) NULL,
    [IsFramework] BIT NULL,
    [UpdatedAt] DATETIME2 NULL,
    CONSTRAINT [PK_PurchaseOrder] PRIMARY KEY NONCLUSTERED ([PurchaseOrderKey])
);
GO
