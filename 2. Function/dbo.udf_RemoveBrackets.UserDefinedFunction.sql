USE [Utility]
GO

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
