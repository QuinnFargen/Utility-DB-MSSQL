USE [Helper]
GO
/****** Object:  StoredProcedure [Logs].[ProcLog_Query]    Script Date: 2/17/2024 4:27:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================		
-- Author:		Quinn Fargen
-- Create date: 2024.02.16
-- Description:	Query by Object Name of Logs.ProcLog
-- =============================================	  */

CREATE PROCEDURE [Logs].[ProcLog_Query]

@ObjNamePARAM NVARCHAR(255)
	
AS
BEGIN

	SET NOCOUNT ON;

	/*	-- Testing
	
	DECLARE @ObjNamePARAM NVARCHAR(255) = 'Calendar'
	--	DECLARE @ObjNamePARAM NVARCHAR(255) = 'tbl.Calendar'
	--	DECLARE @ObjNamePARAM NVARCHAR(255) = 'Helper..Calendar'
	--	DECLARE @ObjNamePARAM NVARCHAR(255) = '[tbl].Calendar'
	--	DECLARE @ObjNamePARAM NVARCHAR(255) = '[tbl].[Calendar]'
	--	DECLARE @ObjNamePARAM NVARCHAR(255) = 'Helper.[tbl].Calendar'

	-- */
	
	DECLARE @ObjName NVARCHAR(255) = dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A ORDER BY A.ordinal DESC ) )
		,@SchemaName NVARCHAR(255) = NULL
		,@DatabaseName NVARCHAR(255) = NULL
		,@NumNames tinyint = ( SELECT TOP 1 A.ordinal FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A ORDER BY A.ordinal DESC )
		,@dboFlag tinyint = (SELECT CASE WHEN @ObjNamePARAM LIKE '%..%' THEN 1 ELSE 0 END)
		,@ProcedureName [nvarchar](400) = NULL
		
	IF @NumNames = 2	/* Assume DB.Schema.Object */
		BEGIN
			SELECT @SchemaName = (SELECT dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 1 ) ) )
					,@DatabaseName = DB_NAME()
		END

	IF @NumNames = 3	/* Assume DB.Schema.Object */
		BEGIN
			SELECT @SchemaName = (SELECT CASE WHEN @dboFlag = 1 THEN 'dbo' ELSE dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 2 ) ) END )
					,@DatabaseName = (SELECT dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 1 ) ) )
		END
		
	--SELECT @DatabaseName, @SchemaName, @ObjName, @NumNames,@dboFlag

	
	SET @ProcedureName = (SELECT dbo.udf_AddBrackets(@DatabaseName + '.' + @SchemaName + '.' + @ObjName))

	--SELECT @ProcedureName


	SELECT TOP 50 
		A.PLID, A.LogDate, A.LogDateEnd, A.LoginName, A.ExecPLID, A.ExecName, A.ProcedureName
	FROM Logs.ProcLog A
	WHERE A.ProcedureName = @ProcedureName
	ORDER BY A.PLID DESC


END

GO
