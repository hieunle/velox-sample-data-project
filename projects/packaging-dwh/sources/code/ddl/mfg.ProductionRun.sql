-- Object: mfg.ProductionRun
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
-- HASH(MachineKey), 4 partitions on ProductionDateKey: clustered by ProductionDateKey
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[ProductionRun]
(
    [ProductionRunKey] BIGINT NOT NULL,
    [MachineKey] INT NOT NULL,
    [LineKey] INT NOT NULL,
    [PlantKey] INT NOT NULL,
    [ProductKey] INT NOT NULL,
    [ProductionDateKey] INT NOT NULL,
    [ShiftStart] TIME NULL,
    [StartedAt] DATETIMEOFFSET NULL,
    [DurationMinutes] SMALLINT NULL,
    [BatchCode] NVARCHAR(20) NOT NULL,
    [UnitsPlanned] BIGINT NULL,
    [UnitsProduced] BIGINT NULL,
    [UnitsRejected] INT NULL,
    [ScrapKg] DECIMAL(12, 3) NULL,
    [EnergyKwh] DECIMAL(12, 3) NULL,
    [WaterLitres] DECIMAL(12, 2) NULL,
    [Oee] FLOAT NULL,
    [Availability] FLOAT NULL,
    [Performance] FLOAT NULL,
    [QualityRate] FLOAT NULL,
    [SterilantPpm] REAL NULL,
    [Zone1TempC] DECIMAL(5, 1) NULL,
    [Zone2TempC] DECIMAL(5, 1) NULL,
    [Zone3TempC] DECIMAL(5, 1) NULL,
    [SealPressureBar] DECIMAL(5, 2) NULL,
    [WebSpeedMpm] DECIMAL(7, 2) NULL,
    [GlueGrams] DECIMAL(9, 3) NULL,
    [InkGrams] DECIMAL(9, 3) NULL,
    [Stoppages] TINYINT NULL,
    [DowntimeMinutes] SMALLINT NULL,
    [ChangeoverMinutes] SMALLINT NULL,
    [OperatorCount] TINYINT NULL,
    [OperatorId] NVARCHAR(12) NULL,
    [IsTrial] BIT NULL,
    [ReleasedAt] DATETIME2 NULL,
    [QaComment] NVARCHAR(400) NULL
);
GO
