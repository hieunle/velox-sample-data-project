-- Object: sales.Invoice
-- Scripted from PACKDWH01\veloxpool by SSMS, 2026-09-30
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE TABLE [sales].[Invoice]
(
    [InvoiceKey] BIGINT NOT NULL,
    [InvoiceNumber] NVARCHAR(20) NOT NULL,
    [SalesOrderKey] BIGINT NOT NULL,
    [CustomerKey] INT NOT NULL,
    [InvoiceDateKey] INT NOT NULL,
    [IssuedAt] DATETIMEOFFSET NULL,
    [DueDate] DATE NULL,
    [PaidOn] DATE NULL,
    [Currency] CHAR(3) NULL,
    [NetAmount] MONEY NOT NULL,
    [TaxAmount] MONEY NULL,
    [GrossAmount] MONEY NULL,
    [ExchangeRate] DECIMAL(12, 6) NULL,
    [PaymentMethod] NVARCHAR(20) NULL,
    [DunningLevel] TINYINT NULL,
    [IsCreditNote] BIT NULL,
    [Reference] NVARCHAR(40) NULL,
    [UpdatedAt] DATETIME2 NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY NONCLUSTERED ([InvoiceKey])
);
GO
