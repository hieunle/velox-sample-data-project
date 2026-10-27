-- Object: sales.CustomerSite
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [sales].[CustomerSite]
(
    [SiteKey] INT NOT NULL,
    [CustomerKey] INT NOT NULL,
    [SiteCode] NVARCHAR(14) NOT NULL,
    [SiteType] NVARCHAR(20) NULL,
    [AddressLine] NVARCHAR(120) NULL,
    [City] NVARCHAR(60) NULL,
    [Country] NVARCHAR(40) NULL,
    [Latitude] DECIMAL(9, 6) NULL,
    [Longitude] DECIMAL(9, 6) NULL,
    [DockDoors] TINYINT NULL,
    [OpeningTime] TIME NULL,
    [ClosingTime] TIME NULL,
    [IsActive] BIT NULL,
    [DeliveryInstructions] NVARCHAR(400) NULL
);
GO
