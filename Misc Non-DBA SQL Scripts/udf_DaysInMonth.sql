USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_DaysInMonth]    Script Date: 10/8/2021 10:05:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_DaysInMonth] (@Month Int, @Year Int)
RETURNS @Days Table ([date] DateTime)
AS
BEGIN

	DECLARE @StartDate DateTime
	DECLARE @EndDate DateTime

	SET @StartDate = CONVERT(Varchar(2), @Month) + '/1/' + CONVERT(Char(4),@Year)
	SET @EndDate = DATEADD(MONTH, 1, (CONVERT(Varchar(2), @Month) + '/1/' + CONVERT(Char(4),@Year)))

	DECLARE @Date DateTime
	SET @Date = @StartDate
	
	WHILE @Date < @EndDate
	BEGIN
		INSERT @Days 
		VALUES (@Date)

		SET @Date = DATEADD(DAY, 1, @Date)
	END	

	RETURN
END
GO


