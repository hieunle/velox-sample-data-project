-- Object: mfg.Material
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[Material]
(
    [MaterialKey] INT NOT NULL,
    [MaterialCode] NVARCHAR(20) NOT NULL,
    [MaterialName] NVARCHAR(80) NULL,
    [Category] NVARCHAR(30) NULL,
    [UnitOfMeasure] VARCHAR(5) NULL,
    [GramsPerM2] DECIMAL(9, 2) NULL,
    [RenewableContentPct] FLOAT NULL,
    [StandardCostEur] SMALLMONEY NULL,
    [FoodContactApproved] BIT NULL,
    [ApprovedOn] DATE NULL,
    [ShelfLifeDays] SMALLINT NULL,
    [HazardClass] VARCHAR(10) NULL
);
GO
