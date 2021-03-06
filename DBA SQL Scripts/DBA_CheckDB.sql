USE [master]
GO
/****** Object:  StoredProcedure [dbo].[DBA_CheckDB]    Script Date: 10/8/2021 9:54:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-11-29
-- Description:	Job Executes CheckDB on each 
--				database once per week
-- =============================================
CREATE PROCEDURE [dbo].[DBA_CheckDB] 

AS
BEGIN
SET NOCOUNT ON;

DECLARE	@listStr VARCHAR(MAX); 

IF		DATEPART(WEEKDAY,GETDATE())%7 = 1 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %7 = 1 

ELSE 

IF		DATEPART(WEEKDAY,GETDATE())%7 = 2 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %7 = 2 

ELSE 

IF		DATEPART(WEEKDAY,GETDATE())%7 = 3 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %7 = 3 
		
ELSE 

IF		DATEPART(WEEKDAY,GETDATE())%7 = 4 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %7 = 4 
		
ELSE 

IF		DATEPART(WEEKDAY,GETDATE())%7 = 5 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %7 = 5 
		
ELSE 

IF		DATEPART(WEEKDAY,GETDATE())%7 = 6 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %7 = 6 

ELSE 

IF		DATEPART(WEEKDAY,GETDATE())%7 = 0 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %7 = 0 
		
SET		@listStr = ISNULL(@listStr, 'master'); 

EXEC	master.dbo.DatabaseIntegrityCheck 
		@Databases = @listStr
		, @DatabasesInParallel = 'Y'
		, @CheckCommands = 'CheckDB'
		, @LogToTable = 'Y'
		, @MaxDOP = 2
		, @PhysicalOnly = 'Y'

END
