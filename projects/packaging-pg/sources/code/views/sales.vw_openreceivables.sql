-- Object: sales.vw_openreceivables
-- Finance dunning report (Metabase question "Open receivables", daily 07:00). Owner: Finance BI.
CREATE OR REPLACE VIEW sales.vw_openreceivables AS
SELECT
    c.customercode, c.customername, c.accountmanager, i.invoicenumber, i.currency, i.grossamount, i.duedate,
    -- Rule R-INV-6: an invoice is overdue when unpaid after DueDate; dunning level 1 after 7 days, 2 after 30, 3 after 60.
    current_date - i.duedate AS daysoverdue,
    CASE WHEN current_date - i.duedate > 60 THEN 3
         WHEN current_date - i.duedate > 30 THEN 2
         WHEN current_date - i.duedate > 7  THEN 1 ELSE 0 END AS expecteddunninglevel
FROM sales.invoice AS i
JOIN sales.customer AS c ON c.customerkey = i.customerkey
WHERE i.paidon IS NULL AND NOT i.iscreditnote AND i.duedate < current_date;
