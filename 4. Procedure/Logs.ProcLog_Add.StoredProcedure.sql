USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     PROCEDURE [Logs].[ProcLog_Add]

	@ObjectID       INT,
	@ExecSPID		SMALLINT = NULL,
	@ExecPLID		INT = NULL,
	@ExecProcess	varchar(250) = 'ManualExec',
	@PLID			INT OUTPUT

AS
BEGIN

    SET NOCOUNT ON;
    SET XACT_ABORT ON;

	DECLARE 
		@ProcedureName NVARCHAR(400)
		,@DatabaseID INT =  DB_ID()
  
	SELECT
		@ProcedureName = COALESCE
		(
		QUOTENAME(DB_NAME(@DatabaseID)) 
		+ '.' + QUOTENAME(OBJECT_SCHEMA_NAME(@ObjectID, @DatabaseID)) 
		+ '.' + QUOTENAME(OBJECT_NAME(@ObjectID, @DatabaseID)),
		ERROR_PROCEDURE()
		);

	INSERT Logs.[ProcLog]
		(
		[LoginName]
		,[ExecSPID]
		,[ExecPLID]
		,[ExecName]
		,[ProcedureName]
		)
	SELECT
		SUSER_NAME(),
		@ExecSPID,
		@ExecPLID,
		@ExecProcess,
		@ProcedureName;

	SET @PLID = SCOPE_IDENTITY()

	-- https://www.mssqltips.com/sqlservertip/2003/simple-process-to-track-and-log-sql-server-stored-procedure-use/
	-- https://www.mssqltips.com/sqlservertip/7024/sql-return-sql-output-clause-stored-procedure/

	/*
	
	CREATE TABLE [Logs].[ProcLog](
		[PLID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[LogDate] [smalldatetime] NOT NULL DEFAULT (getdate()),
		[LogDateEnd] [smalldatetime] NULL,
		[LoginName] [sysname] NULL,
		[ExecSPID] [smallint] NULL,
		[ExecPLID] [int] NULL,
		[ExecName] [nvarchar](400) NULL,
		[ProcedureName] [nvarchar](400) NULL
		)

	*/



END
GO
