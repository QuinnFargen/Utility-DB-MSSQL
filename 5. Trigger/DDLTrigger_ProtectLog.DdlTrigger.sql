USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [DDLTrigger_ProtectLog]
    ON DATABASE
    FOR  ALTER_PROCEDURE	, DROP_PROCEDURE
		,ALTER_TABLE		, DROP_TABLE
		, ALTER_FUNCTION	, DROP_FUNCTION
		, ALTER_VIEW		, DROP_VIEW
AS
BEGIN
    SET NOCOUNT ON;
	
	/* https://www.sqlshack.com/database-level-ddl-triggers-for-views-procedures-and-functions/ */

    DECLARE
        @EventData XML = EVENTDATA()
		
    DECLARE
		@ALTERFlag bit = (CASE WHEN @EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)') LIKE 'ALTER%' THEN 1 ELSE 0 END)
		,@DatabaseName NVARCHAR(255) = DB_NAME()
		,@SchemaName NVARCHAR(255) = @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)') 
		,@ObjectName NVARCHAR(255) = @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)')
		,@ip varchar(48) = CONVERT(varchar(48),  CONNECTIONPROPERTY('client_net_address'))
		,@AllowTran bit
		,@UnAllowedMSG NVARCHAR(100) = 'Operation on object is protected with Logs.DDLProtect'

 
	SET @AllowTran = (
			SELECT TOP 1 CASE WHEN @ALTERFlag = 1 THEN P.AllowALTER ELSE P.AllowDROP END
			FROM Logs.DDLProtect P
			WHERE P.DatabaseName = @DatabaseName AND P.SchemaName = @SchemaName AND P.ObjectName = @ObjectName
			)

	IF @AllowTran = 0	/* Log attempt & Rollback Transaction */
	BEGIN
 
		PRINT @UnAllowedMSG;
		ROLLBACK;

		INSERT [Logs].DDLEvents
		(
			EventType,
			EventDDL,
			EventXML,
			DatabaseName,
			SchemaName,
			ObjectName,
			HostName,
			IPAddress,
			ProgramName,
			LoginName
		)
		SELECT
			@EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)') + '_ATTEMPT', 
			@EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
			@EventData,
			DB_NAME(),
			@EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)'), 
			@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),
			HOST_NAME(),
			@ip,
			PROGRAM_NAME(),
			SUSER_SNAME();

	END /* IF @AllowTran = 0 */


END



	--------------------------------------------------------------

	/*
		--	CREATE SCHEMA [Logs]

		DROP TABLE IF EXISTS [Logs].DDLProtect	
			CREATE TABLE [Logs].DDLProtect
			(
				DDLPID		 INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				InsertDate    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,	
				DatabaseName NVARCHAR(255) NOT NULL,
				SchemaName   NVARCHAR(255) NOT NULL,
				ObjectName   NVARCHAR(255) NOT NULL,			
				ObjectType    NVARCHAR(64) NOT NULL,
				AllowALTER		bit NOT NULL DEFAULT (0),
				AllowDROP		bit NOT NULL DEFAULT (0)
			);

			
		INSERT INTO [Logs].DDLProtect
		(
			DatabaseName,
			SchemaName,
			ObjectName,
			ObjectType
		)
		SELECT			
			DB_NAME(),
			OBJECT_SCHEMA_NAME(O.[object_id]),
			OBJECT_NAME(O.[object_id]),
			[EventType] = CASE	WHEN O.type IN ('FN','IF') THEN 'FUNCTION' 
								WHEN O.type = 'P' THEN 'PROCEDURE'
								WHEN O.type = 'V' THEN 'VIEW'
								WHEN O.type = 'U' THEN 'TABLE'
								ELSE NULL END
		FROM sys.schemas S
		JOIN sys.objects O on S.schema_id = O.schema_id
		WHERE O.type IN ('FN','IF','P','V','U')

	*/


GO
DISABLE TRIGGER [DDLTrigger_ProtectLog] ON DATABASE
GO
ENABLE TRIGGER [DDLTrigger_ProtectLog] ON DATABASE
GO
