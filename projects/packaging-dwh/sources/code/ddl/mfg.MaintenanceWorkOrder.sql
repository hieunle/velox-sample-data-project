-- Object: mfg.MaintenanceWorkOrder
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[MaintenanceWorkOrder]
(
    [WorkOrderKey] INT NOT NULL,
    [WorkOrderNumber] NVARCHAR(20) NOT NULL,
    [MachineKey] INT NOT NULL,
    [WorkType] NVARCHAR(30) NULL,
    [Priority] TINYINT NULL,
    [Status] NVARCHAR(20) NULL,
    [ReportedAt] DATETIMEOFFSET NULL,
    [StartedAt] DATETIME2 NULL,
    [CompletedAt] DATETIME2 NULL,
    [PlannedHours] DECIMAL(6, 2) NULL,
    [ActualHours] DECIMAL(6, 2) NULL,
    [LabourCostEur] MONEY NULL,
    [PartsCostEur] MONEY NULL,
    [Technician] NVARCHAR(12) NULL,
    [FailureMode] NVARCHAR(60) NULL,
    [SparePartCode] VARCHAR(20) NULL,
    [DowntimeMinutes] INT NULL,
    [SafetyRelated] BIT NULL,
    [Description] NVARCHAR(400) NULL,
    [ExternalId] UNIQUEIDENTIFIER NULL
);
GO
