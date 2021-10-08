USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[HtmlSafe]    Script Date: 10/8/2021 10:06:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[HtmlSafe] (@str Varchar(200))
RETURNS Varchar(200)
AS
BEGIN

	SET @str = REPLACE(@str, '"', '')
	SET @str = REPLACE(@str, '''', '')
	SET @str = REPLACE(@str, ',', '')
	SET @str = REPLACE(@str, '.', '')
	SET @str = REPLACE(@str, ' ', '-')

	RETURN @str

END
GO


