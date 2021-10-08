USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_StripAlpha]    Script Date: 10/8/2021 10:05:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_StripAlpha]
	(@input Varchar(100))
RETURNS Varchar(100)
AS
BEGIN
	DECLARE @x Int
	SELECT @x = 0
	WHILE @x < 256
	BEGIN
		IF @x < 48 OR @x > 57 SELECT @input = REPLACE(@input, CHAR(@x), '')
		SELECT @x = @x + 1
	END
	
	RETURN @input
END
GO


