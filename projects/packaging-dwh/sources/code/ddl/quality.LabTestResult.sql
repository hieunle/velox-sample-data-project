-- Object: quality.LabTestResult
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [quality].[LabTestResult]
(
    [TestKey] BIGINT NOT NULL,
    [SampleCode] NVARCHAR(20) NOT NULL,
    [MaterialKey] INT NOT NULL,
    [PurchaseOrderKey] BIGINT NULL,
    [TestDateKey] INT NOT NULL,
    [TestedAt] DATETIME2 NULL,
    [Method] NVARCHAR(40) NULL,
    [ResultValue] DECIMAL(12, 4) NULL,
    [Unit] VARCHAR(10) NULL,
    [SpecMin] DECIMAL(12, 4) NULL,
    [SpecMax] DECIMAL(12, 4) NULL,
    [WithinSpec] BIT NOT NULL,
    [Uncertainty] REAL NULL,
    [Analyst] NVARCHAR(12) NULL,
    [Instrument] NVARCHAR(40) NULL,
    [ApprovedBy] NVARCHAR(12) NULL,
    [ApprovedAt] DATETIMEOFFSET NULL,
    [SampleTime] TIME NULL,
    [ExternalLabId] UNIQUEIDENTIFIER NULL,
    [Comment] NVARCHAR(400) NULL
);
GO
