USE [master]
GO
/****** Object:  StoredProcedure [dbo].[DBA_DiffBackups]    Script Date: 10/8/2021 9:54:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-11-29
-- Description:	Calls other stored procedure to
--				backup databases differentially
--				based on specified criteria
-- =============================================
CREATE PROCEDURE [dbo].[DBA_DiffBackups] 
AS
BEGIN
SET NOCOUNT ON;

DECLARE @listStr Varchar(MAX); 

SELECT	@listStr = COALESCE(@listStr + ', ' ,'') + D.name 
FROM	master.sys.databases D 
WHERE	D.state_desc = 'ONLINE' 
		AND DB_NAME(D.database_id) <> 'tempdb' 
		AND D.recovery_model <> 3; 
		
EXECUTE	master.dbo.DatabaseBackup 
		@BackupType = 'DIFF'
		, @CheckSum = 'Y'
		, @CleanupTime = 72
		, @CleanupMode = 'AFTER_BACKUP'
		, @Compress = 'Y'
		, @Databases = @listStr
		, @DatabasesInParallel = 'Y'
		, @Directory = '\\254-idpa-dd1.pharmaca.com\DB1-Backups'
		, @LogToTable = 'Y'
		, @ChangeBackupType = 'Y'

END
