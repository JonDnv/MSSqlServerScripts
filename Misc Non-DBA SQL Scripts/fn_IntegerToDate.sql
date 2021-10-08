USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_IntegerToDate]    Script Date: 10/8/2021 10:05:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[fn_IntegerToDate]
(	
	@Integer_Date	Integer,
	@Integer_Time	Integer
)

RETURNS DateTime
AS
BEGIN


DECLARE	@Int_Year	Integer
DECLARE	@Int_Month	Integer
DECLARE	@Int_Day	Integer
DECLARE	@Int_Hour	Integer
DECLARE	@Int_Min	Integer
DECLARE	@Converted_Date Varchar(255)



--
-- Integer division will truncate remainder
--
SELECT	@Int_Year 	= (@Integer_Date / 10000)
SELECT	@Int_Month	= (@Integer_Date - @Int_Year*10000) / 100	
SELECT	@Int_Day 	= (@Integer_Date - @Int_Year*10000 - @Int_Month*100)

SELECT	@Int_Hour 	= (@Integer_Time / 10000)
SELECT	@Int_Min	= (@Integer_Time - @Int_Hour*10000) / 100	

SELECT 	@Converted_Date = CONVERT(Varchar(2),@Int_Month) + '/'
			+ CONVERT(Varchar(2),@Int_Day) + '/'
			+ CONVERT(Varchar(4),@Int_Year) + ' '
			+ CONVERT(Varchar(2),@Int_Hour) + ':'
			+ CONVERT(Varchar(2),@Int_Min) + ':'
			+ '00'


RETURN (CONVERT(DateTime, @Converted_Date))
  

END
GO


