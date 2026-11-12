-- Object: sales.sp_build_invoice
-- Runs after the SAP billing export lands (pg_cron job dwh_nightly, step 4). Owner: Finance BI.
CREATE SEQUENCE IF NOT EXISTS sales.seq_invoice START 1000001;

CREATE OR REPLACE PROCEDURE sales.sp_build_invoice(p_order_date_key int)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Rule R-INV-1: an invoice's NetAmount is the sum of its order lines' LineAmount, in the order's currency.
    -- Rule R-INV-2: GrossAmount = NetAmount + TaxAmount; a credit note carries negative amounts.
    MERGE INTO sales.invoice AS tgt
    USING (
        SELECT g.*, nextval('sales.seq_invoice') AS newkey  -- one key per row, used twice below
        FROM (
            SELECT o.salesorderkey, o.customerkey, o.currency,
                   SUM(l.lineamount) AS netamount, SUM(l.taxamount) AS taxamount
            FROM sales.salesorder AS o
            JOIN sales.orderline AS l ON l.salesorderkey = o.salesorderkey
            WHERE o.orderdatekey = p_order_date_key AND o.status IN ('Shipped', 'Invoiced')
            GROUP BY o.salesorderkey, o.customerkey, o.currency
        ) AS g
    ) AS src ON src.salesorderkey = tgt.salesorderkey AND NOT tgt.iscreditnote
    WHEN MATCHED THEN UPDATE SET
        netamount = src.netamount, taxamount = src.taxamount,
        grossamount = src.netamount + src.taxamount, updatedat = localtimestamp
    WHEN NOT MATCHED THEN INSERT
        (invoicekey, invoicenumber, salesorderkey, customerkey, invoicedatekey, issuedat, duedate, currency,
         netamount, taxamount, grossamount, exchangerate, iscreditnote, updatedat)
    VALUES
        (src.newkey, 'INV' || lpad(src.newkey::text, 8, '0'),
         src.salesorderkey, src.customerkey, p_order_date_key, now(),
         -- Rule R-INV-3: DueDate = IssuedAt + the customer's PaymentTermsDays.
         current_date + (SELECT c.paymenttermsdays FROM sales.customer c WHERE c.customerkey = src.customerkey),
         src.currency, src.netamount, src.taxamount, src.netamount + src.taxamount, 1.0, false, localtimestamp);
END;
$$;
