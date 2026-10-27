-- Object: supply.Shipment
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
-- HASH(CustomerKey), 12 partitions on ShipDateKey: clustered by ShipDateKey
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [supply].[Shipment]
(
    [ShipmentKey] BIGINT NOT NULL,
    [ShipmentNumber] NVARCHAR(20) NOT NULL,
    [SalesOrderKey] BIGINT NOT NULL,
    [CustomerKey] INT NOT NULL,
    [SiteKey] INT NOT NULL,
    [WarehouseKey] INT NOT NULL,
    [ShipDateKey] INT NOT NULL,
    [ShippedAt] DATETIMEOFFSET NULL,
    [DeliveredAt] DATETIMEOFFSET NULL,
    [Carrier] NVARCHAR(40) NULL,
    [TransportMode] NVARCHAR(10) NULL,
    [Pallets] SMALLINT NULL,
    [GrossWeightKg] DECIMAL(12, 2) NULL,
    [FreightCostEur] MONEY NULL,
    [Co2Kg] DECIMAL(10, 2) NULL,
    [TrackingNumber] VARCHAR(30) NULL,
    [Status] NVARCHAR(20) NULL,
    [DelayMinutes] INT NULL,
    [TemperatureLogged] BIT NULL,
    [UpdatedAt] DATETIME2 NULL,
    CONSTRAINT [PK_Shipment] PRIMARY KEY NONCLUSTERED ([ShipmentKey, ShipDateKey])
);
GO
