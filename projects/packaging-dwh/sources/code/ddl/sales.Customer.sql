-- Object: sales.Customer
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [sales].[Customer]
(
    [CustomerKey] INT IDENTITY(1, 1) IDENTITY(1, 1) NOT NULL,
    [CustomerCode] NVARCHAR(12) NOT NULL,
    [CustomerName] NVARCHAR(100) NOT NULL,
    [Segment] NVARCHAR(30) NOT NULL,
    [Country] NVARCHAR(40) NULL,
    [City] NVARCHAR(60) NULL,
    [PostalCode] VARCHAR(12) NULL,
    [VatNumber] VARCHAR(20) NULL,
    [ContactEmail] NVARCHAR(120) NULL,
    [ContactPhone] VARCHAR(20) NULL,
    [AccountManager] NVARCHAR(80) NULL,
    [PaymentTermsDays] TINYINT NULL,
    [Currency] CHAR(3) NULL,
    [CreditLimit] MONEY NULL,
    [CreditRating] CHAR(2) NULL,
    [CustomerSince] DATE NULL,
    [IsKeyAccount] BIT NULL,
    [SustainabilityTier] NVARCHAR(20) NULL,
    [AnnualVolumeMillionPacks] DECIMAL(9, 2) NULL,
    [CreatedAt] DATETIMEOFFSET NULL,
    [UpdatedAt] DATETIME2 NULL,
    [Notes] NVARCHAR(400) NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY NONCLUSTERED ([CustomerKey])
);
GO
