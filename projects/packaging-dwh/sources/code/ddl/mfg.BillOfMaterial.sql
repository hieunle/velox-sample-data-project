-- Object: mfg.BillOfMaterial
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [mfg].[BillOfMaterial]
(
    [BomLineKey] INT NOT NULL,
    [ProductKey] INT NOT NULL,
    [MaterialKey] INT NOT NULL,
    [QuantityPerThousand] DECIMAL(12, 4) NULL,
    [UnitOfMeasure] VARCHAR(5) NULL,
    [ScrapAllowancePct] FLOAT NULL,
    [ValidFrom] DATE NULL,
    [ValidTo] DATE NULL,
    [Revision] SMALLINT NULL,
    [IsAlternative] BIT NULL
);
GO
