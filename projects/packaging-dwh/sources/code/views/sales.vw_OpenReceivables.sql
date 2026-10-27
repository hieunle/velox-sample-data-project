-- Object: sales.vw_OpenReceivables
-- Finance dunning report (SSRS rpt_open_receivables, daily 07:00). Owner: Finance BI.
CREATE OR ALTER VIEW [sales].[vw_OpenReceivables]
AS
SELECT
    c.CustomerCode, c.CustomerName, c.AccountManager, i.InvoiceNumber, i.Currency, i.GrossAmount, i.DueDate,
    -- Rule R-INV-6: an invoice is overdue when unpaid after DueDate; dunning level 1 after 7 days, 2 after 30, 3 after 60.
    DATEDIFF(day, i.DueDate, CAST(SYSDATETIME() AS DATE)) AS DaysOverdue,
    CASE WHEN DATEDIFF(day, i.DueDate, SYSDATETIME()) > 60 THEN 3
         WHEN DATEDIFF(day, i.DueDate, SYSDATETIME()) > 30 THEN 2
         WHEN DATEDIFF(day, i.DueDate, SYSDATETIME()) > 7  THEN 1 ELSE 0 END AS ExpectedDunningLevel
FROM sales.Invoice AS i
JOIN sales.Customer AS c ON c.CustomerKey = i.CustomerKey
WHERE i.PaidOn IS NULL AND i.IsCreditNote = 0 AND i.DueDate < CAST(SYSDATETIME() AS DATE);
GO
