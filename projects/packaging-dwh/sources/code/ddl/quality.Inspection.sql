-- Object: quality.Inspection
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
-- ROUND_ROBIN heap, no key, a case-sensitive batch code
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [quality].[Inspection]
(
    [InspectionId] BIGINT NOT NULL,
    [BatchCode] NVARCHAR(20) COLLATE Latin1_General_100_CS_AS NOT NULL,
    [ProductionRunKey] BIGINT NOT NULL,
    [PlantKey] INT NULL,
    [CheckType] VARCHAR(30) NOT NULL,
    [SampleSize] SMALLINT NULL,
    [Passed] BIT NOT NULL,
    [DefectCode] VARCHAR(10) NULL,
    [MeasuredValue] DECIMAL(10, 4) NULL,
    [LowerLimit] DECIMAL(10, 4) NULL,
    [UpperLimit] DECIMAL(10, 4) NULL,
    [InspectedAt] DATETIME2 NULL,
    [Inspector] NVARCHAR(12) NULL,
    [Instrument] NVARCHAR(40) NULL,
    [Comment] NVARCHAR(400) NULL,
    [ShiftStart] TIME NULL
);
GO
