USE [Helper]
GO
/****** Object:  StoredProcedure [Logs].[DDLProtect_Insert]    Script Date: 2/17/2024 4:27:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* =============================================		
-- Author:		Quinn Fargen
-- Create date: 2024.02.16
-- Description:	Insert by Object Name into DDLProtect
-- =============================================	  */

CREATE PROCEDURE [Logs].[DDLProtect_Insert]

@ObjNamePARAM NVARCHAR(255)
	
AS
BEGIN

	SET NOCOUNT ON;

	/*	-- Testing
	
	DECLARE @ObjNamePARAM NVARCHAR(255) = '[Helper].[dbo].[udf_tblGetEasterHolidays]'

	-- */
	
	DECLARE @NumNames NVARCHAR(255) =( SELECT TOP 1 A.ordinal FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A ORDER BY A.ordinal DESC )
			,@DatabaseName NVARCHAR(255) = dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 1 ) )

	IF COALESCE(@NumNames,0) <> 3 OR COALESCE(@DatabaseName,'') <> DB_NAME()
	BEGIN
		PRINT 'Database not included in Object Param or Not Exec SP on Objects DB'
	END
	ELSE BEGIN
	
		DECLARE @ObjectName NVARCHAR(255) = dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 3 ) )
			,@SchemaName NVARCHAR(255) = dbo.[udf_RemoveBrackets]( ( SELECT TOP 1 A.value FROM STRING_SPLIT(@ObjNamePARAM,'.',1) A WHERE A.ordinal = 2 ) )
			,@ObjectType NVARCHAR(64)						

				SELECT @ObjectType = CASE	WHEN O.type IN ('FN','IF') THEN 'FUNCTION' 	
										WHEN O.type = 'P' THEN 'PROCEDURE'
										WHEN O.type = 'V' THEN 'VIEW'							
										WHEN O.type = 'U' THEN 'TABLE'		ELSE NULL END
				FROM sys.schemas S
				JOIN sys.objects O on S.schema_id = O.schema_id
				WHERE S.name = @SchemaName AND O.name = @ObjectName

		IF NOT EXISTS (SELECT * FROM Logs.DDLProtect A WHERE A.DatabaseName = @DatabaseName AND A.SchemaName = @SchemaName AND A.ObjectName = @ObjectName AND A.ObjectType = @ObjectType)
		BEGIN
			INSERT INTO Logs.DDLProtect (DatabaseName, SchemaName, ObjectName, ObjectType)
			SELECT @DatabaseName, @SchemaName, @ObjectName, @ObjectType
		END

	END

END

GO
