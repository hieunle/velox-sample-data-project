-- Object: mfg.MachineEvent
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[MachineEvent]
(
    [EventKey] BIGINT NOT NULL,
    [MachineKey] INT NOT NULL,
    [EventDateKey] INT NOT NULL,
    [OccurredAt] DATETIMEOFFSET NULL,
    [EventType] NVARCHAR(30) NOT NULL,
    [Severity] TINYINT NULL,
    [AlarmCode] VARCHAR(12) NULL,
    [DurationSeconds] INT NULL,
    [AcknowledgedBy] NVARCHAR(12) NULL,
    [AcknowledgedAt] DATETIME2 NULL,
    [RootCause] NVARCHAR(60) NULL,
    [Message] NVARCHAR(400) NULL,
    [CounterValue] BIGINT NULL,
    [TempC] DECIMAL(5, 1) NULL,
    [VibrationMmS] REAL NULL,
    [IsPlanned] BIT NULL,
    [ShiftStart] TIME NULL,
    [SourceSystem] VARCHAR(20) NULL
);
GO
