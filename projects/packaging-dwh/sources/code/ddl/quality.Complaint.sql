-- Object: quality.Complaint
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [quality].[Complaint]
(
    [ComplaintKey] INT NOT NULL,
    [ComplaintNumber] NVARCHAR(20) NOT NULL,
    [CustomerKey] INT NOT NULL,
    [ProductKey] INT NOT NULL,
    [BatchCode] NVARCHAR(20) NULL,
    [ReceivedAt] DATETIMEOFFSET NULL,
    [Category] NVARCHAR(40) NULL,
    [Severity] TINYINT NULL,
    [Status] NVARCHAR(20) NULL,
    [ClosedOn] DATE NULL,
    [UnitsAffected] INT NULL,
    [CreditNoteAmount] MONEY NULL,
    [RootCause] NVARCHAR(200) NULL,
    [Description] NVARCHAR(400) NULL,
    [Owner] NVARCHAR(12) NULL,
    [IsRecall] BIT NULL
);
GO
