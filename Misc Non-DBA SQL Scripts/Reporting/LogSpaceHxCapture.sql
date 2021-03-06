USE [master]
GO
/****** Object:  StoredProcedure [dbo].[LogSpaceHxCapture]    Script Date: 10/8/2021 9:55:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ================================================================
-- Author:		Jon Godwin
-- Create date: 2018-08-08
-- Description:	Captures Log Usage Stats for Auditing Log File Size
-- ================================================================
ALTER PROCEDURE [dbo].[LogSpaceHxCapture] 
AS
BEGIN
SET NOCOUNT ON;

EXEC master.dbo.sp_foreachdb
'
USE ?
INSERT INTO [000-WINSRV-RPT].[ITReporting].[dbo].[LogSpaceHistory]
(
Instance
, DatabaseID
, DatabaseName
, TotalLogSizeInBytes
, UsedLogSpaceInBytes
, UsedLogSpaceInPercent
, LogSpaceInBytesSinceLastBackup
, QueryDateTime
)
(
SELECT	@@SERVERNAME
		, DDLSU.database_id
		, DB_NAME(DDLSU.database_id)
		, DDLSU.total_log_size_in_bytes
		, DDLSU.used_log_space_in_bytes
		, DDLSU.used_log_space_in_percent
		, DDLSU.log_space_in_bytes_since_last_backup 
		, GetDate()
FROM	sys.dm_db_log_space_usage DDLSU
)
'

END
