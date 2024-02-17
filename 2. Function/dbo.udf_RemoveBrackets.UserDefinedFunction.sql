USE [Helper]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_RemoveBrackets]    Script Date: 2/17/2024 4:27:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_RemoveBrackets]
(
      @Str  nvarchar(255)
)

Returns nvarchar(255)

AS

Begin

  Declare @RetStr nvarchar(255);

  SET @RetStr = REPLACE(REPLACE(@Str,'[',''),']','');

  Return @RetStr;

End;
GO
