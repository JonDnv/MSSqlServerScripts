USE [master]
GO
/****** Object:  StoredProcedure [dbo].[DBA_FullBackups]    Script Date: 10/8/2021 9:55:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-11-29
-- Description:	Executes stored procedures to 
--				complete full backups
-- =============================================
CREATE PROCEDURE [dbo].[DBA_FullBackups] 
AS
BEGIN
SET NOCOUNT ON;

DECLARE @listStr Varchar(MAX);
DECLARE @directoryName Varchar(MAX) = '\\254-idpa-dd1.pharmaca.com\DB1-Backups'

SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb'; 

EXEC	master.dbo.DatabaseBackup 
		@BackupType = 'FULL'
		, @CheckSum = 'Y'
		, @CleanupTime = 72
		, @CleanupMode = 'AFTER_BACKUP'
		, @Compress = 'Y'
		, @Databases = @listStr
		, @DatabasesInParallel = 'Y'
		, @Directory = @directoryName
		, @LogToTable = 'Y'
		, @ChangeBackupType = 'Y'

END
