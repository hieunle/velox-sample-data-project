-- Object: sales.OrderLine
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
-- HASH(CustomerKey), not partitioned: clustered by CustomerKey
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [sales].[OrderLine]
(
    [OrderLineKey] BIGINT NOT NULL,
    [SalesOrderKey] BIGINT NOT NULL,
    [OrderNumber] NVARCHAR(20) NOT NULL,
    [LineNumber] SMALLINT NOT NULL,
    [CustomerKey] INT NOT NULL,
    [ProductKey] INT NOT NULL,
    [PlantKey] INT NOT NULL,
    [OrderDateKey] INT NOT NULL,
    [RequestedDelivery] DATE NULL,
    [Quantity] INT NOT NULL,
    [QuantityShipped] INT NULL,
    [UnitPrice] DECIMAL(19, 4) NOT NULL,
    [DiscountPct] FLOAT NULL,
    [LineAmount] MONEY NULL,
    [TaxAmount] MONEY NULL,
    [Currency] CHAR(3) NULL,
    [PrintDesignCode] NVARCHAR(20) NULL,
    [PalletCount] SMALLINT NULL,
    [OrderedAt] DATETIMEOFFSET NULL,
    [LineStatus] NVARCHAR(20) NULL,
    [IsSample] BIT NULL,
    [UpdatedAt] DATETIME2 NULL,
    CONSTRAINT [PK_OrderLine] PRIMARY KEY NONCLUSTERED ([OrderLineKey])
);
GO
