USE [master]
GO
/****** Object:  StoredProcedure [dbo].[DBA_LogBackups]    Script Date: 10/8/2021 9:55:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-11-30
-- Description:	Performs Log Backups Minutely
--				For All DBs in Full Recovery
-- =============================================
CREATE PROCEDURE [dbo].[DBA_LogBackups] 
AS
BEGIN
SET NOCOUNT ON;

DECLARE @listStr Varchar(MAX)  
DECLARE @directoryName Varchar(MAX) = '\\254-idpa-dd1.pharmaca.com\DB1-Backups'

SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name
FROM	master.sys.databases D
WHERE	D.state_desc = 'ONLINE'
	AND DB_NAME(D.database_id) <> 'tempdb'
	AND D.recovery_model <> 3
	
EXECUTE master.dbo.DatabaseBackup
	@BackupType = 'LOG'
	, @ChangeBackupType = 'Y'
	, @CheckSum = 'Y'
	, @CleanupTime = 72
	, @CleanupMode = 'AFTER_BACKUP'
	, @Compress = 'Y'
	, @Databases = @listStr
	, @Directory = @directoryName
	, @LogToTable = 'Y'

END
