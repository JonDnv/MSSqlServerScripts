USE [master]
GO
/****** Object:  StoredProcedure [dbo].[DBA_IndexMaintenance]    Script Date: 10/8/2021 9:55:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-11-29
-- Description:	Stored procedure executes other
--				stored procedure to complete
--				index maintenance
-- =============================================
CREATE PROCEDURE [dbo].[DBA_IndexMaintenance]
AS
BEGIN
SET NOCOUNT ON;

DECLARE @listStr Varchar(MAX); 

IF		DATEPART(DAY,GETDATE()) %2 = 1 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %2 = 0 
		
ELSE 

IF		DATEPART(DAY,GETDATE()) %2 = 0 
SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.database_id %2 = 1; 
		
EXEC	master.dbo.IndexOptimize 
		@Databases = @listStr
		, @DatabasesInParallel = 'Y'
		, @FillFactor = 90
		, @FragmentationLow = NULL
		, @FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE'
		, @FragmentationHigh = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE'
		, @FragmentationLevel1 = 15
		, @FragmentationLevel2 = 75
		, @LogToTable = 'Y'
		, @MaxDOP = 2
		, @UpdateStatistics = 'ALL'
		, @OnlyModifiedStatistics = 'Y'

END
