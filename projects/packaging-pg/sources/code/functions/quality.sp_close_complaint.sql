-- Object: quality.sp_close_complaint
-- Called by the QMS web app when a complaint is closed. Owner: Quality.
CREATE OR REPLACE PROCEDURE quality.sp_close_complaint(
    p_complaint_key int, p_root_cause varchar(200), p_credit_note_amount numeric(19, 4) DEFAULT NULL)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Rule R-CMP-1: a complaint is Closed only with a root cause; a recall is never closed here.
    IF EXISTS (SELECT 1 FROM quality.complaint WHERE complaintkey = p_complaint_key AND isrecall) THEN
        RAISE EXCEPTION 'A recall is closed by the recall board, not by this procedure';
    END IF;
    UPDATE quality.complaint
       SET status = 'Closed', closedon = current_date, rootcause = p_root_cause,
           creditnoteamount = COALESCE(p_credit_note_amount, creditnoteamount)
     WHERE complaintkey = p_complaint_key AND status IN ('Open', 'Investigating');
END;
$$;
