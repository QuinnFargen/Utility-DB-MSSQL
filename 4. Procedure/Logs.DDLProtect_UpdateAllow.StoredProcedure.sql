USE [Helper]
GO
/****** Object:  StoredProcedure [Logs].[DDLProtect_UpdateAllow]    Script Date: 2/17/2024 4:27:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================		
-- Author:		Quinn Fargen
-- Create date: 2024.02.16
-- Description:	UPDATE Allow by Object Name on Logs.DDLProtect
-- =============================================	  */

CREATE PROCEDURE [Logs].[DDLProtect_UpdateAllow]

@ObjNamePARAM NVARCHAR(255)
	
AS
BEGIN

	SET NOCOUNT ON;

	/*	-- Testing
	
	DECLARE @ObjNamePARAM NVARCHAR(255) = '[Helper].[dbo].[udf_tblGetEasterHolidays]'

	-- */
	
	DECLARE @ObjectName NVARCHAR(255) = dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A ORDER BY A.ordinal DESC ) )
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
		
	--SELECT @DatabaseName, @SchemaName, @ObjectName, @NumNames,@dboFlag

	UPDATE A
	SET AllowALTER = 1
	--SELECT TOP 50 *
	FROM Logs.DDLProtect A
	WHERE A.ObjectName = @ObjectName
		AND ( (@SchemaName IS NOT NULL AND A.SchemaName = @SchemaName) OR @SchemaName IS NULL)
		AND ( (@DatabaseName IS NOT NULL AND A.DatabaseName = @DatabaseName) OR @DatabaseName IS NULL)



END

GO
