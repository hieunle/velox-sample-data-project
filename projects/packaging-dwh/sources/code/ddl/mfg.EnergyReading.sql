-- Object: mfg.EnergyReading
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[EnergyReading]
(
    [ReadingKey] BIGINT NOT NULL,
    [PlantKey] INT NOT NULL,
    [LineKey] INT NOT NULL,
    [ReadingDateKey] INT NOT NULL,
    [ReadingHour] TINYINT NOT NULL,
    [ReadAt] DATETIME2 NULL,
    [ElectricityKwh] DECIMAL(12, 3) NULL,
    [GasM3] DECIMAL(12, 3) NULL,
    [SteamKg] DECIMAL(12, 3) NULL,
    [CompressedAirM3] DECIMAL(12, 3) NULL,
    [PeakKw] DECIMAL(10, 2) NULL,
    [PowerFactor] REAL NULL,
    [Co2Kg] DECIMAL(12, 3) NULL,
    [TariffBand] VARCHAR(10) NULL,
    [IsEstimated] BIT NULL
);
GO
