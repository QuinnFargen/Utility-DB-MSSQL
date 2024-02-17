USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [DDLTrigger_EventLog]
    ON DATABASE
    FOR CREATE_PROCEDURE	, ALTER_PROCEDURE	, DROP_PROCEDURE
		,CREATE_TABLE		, ALTER_TABLE		, DROP_TABLE
		,CREATE_FUNCTION	, ALTER_FUNCTION	, DROP_FUNCTION
		,CREATE_VIEW		, ALTER_VIEW		, DROP_VIEW
		,CREATE_INDEX		, ALTER_INDEX		, DROP_INDEX
AS
BEGIN
    SET NOCOUNT ON;
	
	/* https://www.mssqltips.com/sqlservertip/2085/sql-server-ddl-triggers-to-track-all-database-changes/ */

    DECLARE
        @EventData XML = EVENTDATA();
 
    DECLARE @ip varchar(48) = CONVERT(varchar(48), 
        CONNECTIONPROPERTY('client_net_address'));
 
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
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)'), 
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
        @EventData,
        DB_NAME(),
        @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)'), 
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),
        HOST_NAME(),
        @ip,
        PROGRAM_NAME(),
        SUSER_SNAME();
END



	--------------------------------------------------------------

	/*
		--	CREATE SCHEMA [Logs]

		DROP TABLE IF EXISTS [Logs].DDLEvents	
			CREATE TABLE [Logs].DDLEvents
			(
				EventID		 BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				EventDate    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
				EventType    NVARCHAR(64),
				EventDDL     NVARCHAR(MAX),
				EventXML     XML,
				DatabaseName NVARCHAR(255),
				SchemaName   NVARCHAR(255),
				ObjectName   NVARCHAR(255),
				HostName     VARCHAR(64),
				IPAddress    VARCHAR(48),
				ProgramName  NVARCHAR(255),
				LoginName    NVARCHAR(255)
			);

			
		INSERT INTO [Logs].DDLEvents
		(
			EventType,
			EventDDL,
			DatabaseName,
			SchemaName,
			ObjectName,
			LoginName
		)
		SELECT
			[EventType] = CASE	WHEN O.type IN ('FN','IF') THEN 'CREATE_FUNCTION' 
								WHEN O.type = 'P' THEN 'CREATE_PROCEDURE'
								WHEN O.type = 'V' THEN 'CREATE_VIEW'
								ELSE NULL END, 
			OBJECT_DEFINITION(A.[object_id]),
			DB_NAME(),
			OBJECT_SCHEMA_NAME(A.[object_id]),
			OBJECT_NAME(A.[object_id]),
			'my name'
		FROM sys.sql_modules a
		JOIN sys.objects O on A.object_id = O.object_id
		WHERE O.type IN ('FN','IF','P','V')

	*/


GO
DISABLE TRIGGER [DDLTrigger_EventLog] ON DATABASE
GO
ENABLE TRIGGER [DDLTrigger_EventLog] ON DATABASE
GO
