-- Object: sales.sp_Build_Invoice
-- Runs after the SAP billing export lands (SQL Agent job DWH_Nightly, step 4). Owner: Finance BI.
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE [sales].[sp_Build_Invoice]
    @OrderDateKey INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Rule R-INV-1: an invoice's NetAmount is the sum of its order lines' LineAmount, in the order's currency.
    -- Rule R-INV-2: GrossAmount = NetAmount + TaxAmount; a credit note carries negative amounts.
    MERGE sales.Invoice AS tgt
    USING (
        SELECT o.SalesOrderKey, o.CustomerKey, o.Currency,
               SUM(l.LineAmount) AS NetAmount, SUM(l.TaxAmount) AS TaxAmount
        FROM sales.SalesOrder AS o
        JOIN sales.OrderLine AS l ON l.SalesOrderKey = o.SalesOrderKey
        WHERE o.OrderDateKey = @OrderDateKey AND o.Status IN (N'Shipped', N'Invoiced')
        GROUP BY o.SalesOrderKey, o.CustomerKey, o.Currency
    ) AS src ON src.SalesOrderKey = tgt.SalesOrderKey AND tgt.IsCreditNote = 0
    WHEN MATCHED THEN UPDATE SET
        NetAmount = src.NetAmount, TaxAmount = src.TaxAmount,
        GrossAmount = src.NetAmount + src.TaxAmount, UpdatedAt = SYSDATETIME()
    WHEN NOT MATCHED THEN INSERT
        (InvoiceKey, InvoiceNumber, SalesOrderKey, CustomerKey, InvoiceDateKey, IssuedAt, DueDate, Currency,
         NetAmount, TaxAmount, GrossAmount, ExchangeRate, IsCreditNote, UpdatedAt)
    VALUES
        (NEXT VALUE FOR sales.seq_Invoice, N'INV' + RIGHT(N'00000000' + CAST(NEXT VALUE FOR sales.seq_Invoice AS NVARCHAR(12)), 8),
         src.SalesOrderKey, src.CustomerKey, @OrderDateKey, SYSDATETIME(),
         -- Rule R-INV-3: DueDate = IssuedAt + the customer's PaymentTermsDays.
         DATEADD(day, (SELECT c.PaymentTermsDays FROM sales.Customer c WHERE c.CustomerKey = src.CustomerKey), SYSDATETIME()),
         src.Currency, src.NetAmount, src.TaxAmount, src.NetAmount + src.TaxAmount, 1.0, 0, SYSDATETIME());
END;
GO
