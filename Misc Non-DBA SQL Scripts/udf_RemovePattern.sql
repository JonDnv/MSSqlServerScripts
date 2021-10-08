USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_RemovePattern]    Script Date: 10/8/2021 10:06:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_RemovePattern](@buffer Varchar(8000), @pattern Varchar(50))
RETURNS Varchar(8000) 
AS
/**********************************************************************************
 * Created by: reasonet                                                           *
 * This function removes characters from a string based on a regular expression.  *
 * (Look up "regular expression" for more details on what you can do).			  *
 * Example usage: dbo.udf_RemovePattern('a1! b2@ c3#', '%[^a-z0-9 ]%')            *
 * Example output: 'a1 b2 c3'                                                     *
 * Example meaning: remove all characters that aren't letters, numbers, or spaces *
 **********************************************************************************/
BEGIN
    DECLARE @pos Int
	SET @pos = PATINDEX(@pattern, @buffer)
    WHILE @pos > 0 BEGIN
        SET @buffer = STUFF(@buffer, @pos, 1, '')
        SET @pos = PATINDEX(@pattern, @buffer)
    END
    RETURN @buffer
END
GO


