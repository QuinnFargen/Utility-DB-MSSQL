USE [Helper]
GO
/****** Object:  StoredProcedure [Logs].[ProcLog_End]    Script Date: 2/17/2024 4:27:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     PROCEDURE [Logs].[ProcLog_End]

	@PLID			INT

AS
BEGIN

    SET NOCOUNT ON;
    SET XACT_ABORT ON;

	UPDATE A
	SET LogDateEND = GETDATE()
		,ExecName = ISNULL(A.ExecName,B.ProcedureName)
	FROM Logs.ProcLog A with (NOLOCK)
	LEFT JOIN Logs.ProcLog B with (NOLOCK) ON A.ExecPLID = B.PLID
	WHERE A.PLID = @PLID

END
GO
