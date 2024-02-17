USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================		
-- Author:		Quinn Fargen
-- Create date: 2024.02.16
-- Description:	Query by Object Name of DDLEvents
-- =============================================	  */

CREATE PROCEDURE [Logs].[DDLEvents_Query]

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
		
	IF @NumNames = 2	/* Assume DB.Schema.Object */
		BEGIN
			SELECT @SchemaName = (SELECT dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 1 ) ) )
		END

	IF @NumNames = 3	/* Assume DB.Schema.Object */
		BEGIN
			SELECT @SchemaName = (SELECT CASE WHEN @dboFlag = 1 THEN 'dbo' ELSE dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 2 ) ) END )
					,@DatabaseName = (SELECT dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 1 ) ) )
		END
		
	--SELECT @DatabaseName, @SchemaName, @ObjName, @NumNames,@dboFlag


	SELECT TOP 50 
		A.EventID, A.EventDate, A.EventType, A.EventDDL, A.DatabaseName, A.SchemaName, A.ObjectName, A.LoginName
	FROM Logs.DDLEvents A
	WHERE A.ObjectName = @ObjName
		AND ( (@SchemaName IS NOT NULL AND A.SchemaName = @SchemaName) OR @SchemaName IS NULL)
		AND ( (@DatabaseName IS NOT NULL AND A.DatabaseName = @DatabaseName) OR @DatabaseName IS NULL)
	ORDER BY A.EventID DESC


END

GO
