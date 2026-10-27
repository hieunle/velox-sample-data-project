-- Object: mfg.Plant
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[Plant]
(
    [PlantKey] INT NOT NULL,
    [PlantCode] CHAR(6) NOT NULL,
    [PlantName] NVARCHAR(80) NOT NULL,
    [Country] NVARCHAR(40) NULL,
    [Region] NVARCHAR(20) NULL,
    [City] NVARCHAR(60) NULL,
    [OpenedOn] DATE NULL,
    [FloorAreaM2] INT NULL,
    [Employees] SMALLINT NULL,
    [AnnualCapacityMillionPacks] DECIMAL(9, 1) NULL,
    [IsoCertified] BIT NULL,
    [TimeZone] VARCHAR(10) NULL,
    [Latitude] DECIMAL(9, 6) NULL,
    [Longitude] DECIMAL(9, 6) NULL
);
GO
