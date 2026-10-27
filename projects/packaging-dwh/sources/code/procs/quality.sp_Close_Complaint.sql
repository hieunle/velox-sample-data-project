-- Object: quality.sp_Close_Complaint
-- Called by the QMS web app when a complaint is closed. Owner: Quality.
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER PROCEDURE [quality].[sp_Close_Complaint]
    @ComplaintKey INT, @RootCause NVARCHAR(200), @CreditNoteAmount MONEY = NULL
AS
BEGIN
    SET NOCOUNT ON;
    -- Rule R-CMP-1: a complaint is Closed only with a root cause; a recall is never closed here.
    IF EXISTS (SELECT 1 FROM quality.Complaint WHERE ComplaintKey = @ComplaintKey AND IsRecall = 1)
        THROW 51010, 'A recall is closed by the recall board, not by this procedure', 1;
    UPDATE quality.Complaint
       SET Status = N'Closed', ClosedOn = CAST(SYSDATETIME() AS DATE), RootCause = @RootCause,
           CreditNoteAmount = COALESCE(@CreditNoteAmount, CreditNoteAmount)
     WHERE ComplaintKey = @ComplaintKey AND Status IN (N'Open', N'Investigating');
END;
GO
