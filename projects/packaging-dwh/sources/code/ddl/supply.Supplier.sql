-- Object: supply.Supplier
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [supply].[Supplier]
(
    [SupplierKey] INT IDENTITY(1, 1) IDENTITY(1, 1) NOT NULL,
    [SupplierCode] NVARCHAR(12) NOT NULL,
    [SupplierName] NVARCHAR(100) NOT NULL,
    [Country] NVARCHAR(40) NULL,
    [Category] NVARCHAR(30) NULL,
    [ContactEmail] NVARCHAR(120) NULL,
    [PaymentTermsDays] TINYINT NULL,
    [Currency] CHAR(3) NULL,
    [LeadTimeDays] SMALLINT NULL,
    [QualityScore] DECIMAL(5, 2) NULL,
    [IsFscCertified] BIT NULL,
    [ApprovedSince] DATE NULL,
    [BlockedUntil] DATE NULL,
    [Notes] NVARCHAR(400) NULL,
    CONSTRAINT [PK_Supplier] PRIMARY KEY NONCLUSTERED ([SupplierKey])
);
GO
