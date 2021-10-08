USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[RemoveNonAlphaCharacters]    Script Date: 10/8/2021 10:05:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[RemoveNonAlphaCharacters]
(@Temp Varchar(1000))
RETURNS Varchar(1000)
AS
BEGIN

    DECLARE @KeepValues AS Varchar(50)
    SET @KeepValues = '%[^a-z^0-9]%'
    WHILE PATINDEX(@KeepValues, @Temp) > 0
        SET @Temp = STUFF(@Temp, PATINDEX(@KeepValues, @Temp), 1, '')

    RETURN @Temp
END
GO


