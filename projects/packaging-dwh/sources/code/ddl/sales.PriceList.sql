-- Object: sales.PriceList
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [sales].[PriceList]
(
    [PriceKey] INT NOT NULL,
    [ProductKey] INT NOT NULL,
    [CustomerKey] INT NULL,
    [Currency] CHAR(3) NOT NULL,
    [UnitPrice] DECIMAL(19, 4) NOT NULL,
    [MinQuantity] INT NULL,
    [ValidFrom] DATE NOT NULL,
    [ValidTo] DATE NULL,
    [PriceType] NVARCHAR(20) NULL,
    [ApprovedBy] NVARCHAR(40) NULL,
    [ApprovedAt] DATETIME2 NULL,
    [IsActive] BIT NULL
);
GO
