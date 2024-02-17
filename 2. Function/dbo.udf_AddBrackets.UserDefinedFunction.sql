USE [Helper]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_AddBrackets]    Script Date: 2/17/2024 4:27:54 PM ******/
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
