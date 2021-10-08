USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitDelimited]    Script Date: 10/8/2021 10:04:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SplitDelimited]
(
	@List NVarchar(2000),
	@SplitOn NVarchar(1)
)
RETURNS @RtnValue Table (
	Id Int IDENTITY(1,1),
	Value NVarchar(100)
)
AS
BEGIN
	WHILE (CHARINDEX(@SplitOn,@List)>0)
	BEGIN
		INSERT INTO @RtnValue (value)
		SELECT
			Value = LTRIM(RTRIM(SUBSTRING(@List,1,CHARINDEX(@SplitOn,@List)-1)))
		SET @List = SUBSTRING(@List,CHARINDEX(@SplitOn,@List)+LEN(@SplitOn),LEN(@List))
	END
	
	INSERT INTO @RtnValue (Value)
    SELECT Value = LTRIM(RTRIM(@List))

    RETURN
END
GO


