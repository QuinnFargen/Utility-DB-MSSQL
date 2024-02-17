USE [Utility]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_AddBrackets]
(
      @Str  nvarchar(255)
)

Returns nvarchar(255)

AS

Begin

	/* -- Testing

		DECLARE @Str  nvarchar(255) = 'Helper.tbl.Calendar'

	-- */

  Declare @RetStr nvarchar(255);

  SET @RetStr = ( SELECT STRING_AGG('[' + A.value + ']', '.' ) FROM string_split(@Str,'.') A )

  Return @RetStr;

End;
GO
