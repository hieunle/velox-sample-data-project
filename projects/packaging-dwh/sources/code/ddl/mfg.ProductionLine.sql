-- Object: mfg.ProductionLine
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[ProductionLine]
(
    [LineKey] INT NOT NULL,
    [PlantKey] INT NOT NULL,
    [LineCode] NVARCHAR(10) NOT NULL,
    [LineType] NVARCHAR(40) NULL,
    [Shifts] TINYINT NULL,
    [CommissionedOn] DATE NULL,
    [NominalPacksPerHour] INT NULL,
    [TargetOee] FLOAT NULL,
    [Supervisor] NVARCHAR(80) NULL,
    [IsActive] BIT NULL,
    [LastAuditOn] DATE NULL,
    [Notes] NVARCHAR(400) NULL
);
GO
