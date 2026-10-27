-- Object: sales.SalesOrder
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
-- HASH(CustomerKey), not partitioned: clustered by CustomerKey
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [sales].[SalesOrder]
(
    [SalesOrderKey] BIGINT NOT NULL,
    [OrderNumber] NVARCHAR(20) NOT NULL,
    [CustomerKey] INT NOT NULL,
    [SiteKey] INT NOT NULL,
    [OrderDateKey] INT NOT NULL,
    [OrderedAt] DATETIMEOFFSET NULL,
    [RequestedDelivery] DATE NULL,
    [PromisedDelivery] DATE NULL,
    [Channel] NVARCHAR(20) NULL,
    [Status] NVARCHAR(20) NOT NULL,
    [Currency] CHAR(3) NULL,
    [OrderTotal] MONEY NULL,
    [FreightCost] SMALLMONEY NULL,
    [Incoterm] CHAR(3) NULL,
    [SalesRep] NVARCHAR(12) NULL,
    [PurchaseOrderRef] NVARCHAR(30) NULL,
    [IsRush] BIT NULL,
    [CreatedBy] NVARCHAR(40) NULL,
    [UpdatedAt] DATETIME2 NULL,
    [Comment] NVARCHAR(400) NULL,
    CONSTRAINT [PK_SalesOrder] PRIMARY KEY NONCLUSTERED ([SalesOrderKey])
);
GO
