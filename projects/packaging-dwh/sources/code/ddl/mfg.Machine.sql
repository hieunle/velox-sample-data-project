-- Object: mfg.Machine
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[Machine]
(
    [MachineKey] INT NOT NULL,
    [LineKey] INT NOT NULL,
    [PlantKey] INT NOT NULL,
    [MachineType] NVARCHAR(40) NULL,
    [Model] NVARCHAR(40) NULL,
    [SerialNumber] NVARCHAR(30) NOT NULL,
    [Manufacturer] NVARCHAR(60) NULL,
    [InstalledOn] DATE NULL,
    [WarrantyUntil] DATE NULL,
    [NominalUnitsPerHour] INT NULL,
    [PowerKw] DECIMAL(8, 2) NULL,
    [WeightKg] DECIMAL(10, 1) NULL,
    [FirmwareVersion] VARCHAR(20) NULL,
    [ExternalId] UNIQUEIDENTIFIER NOT NULL,
    [IsCritical] BIT NULL,
    [LastServiceAt] DATETIME2 NULL
);
GO
