USE [master]
GO
/****** Object:  StoredProcedure [dbo].[SprocHxAudit]    Script Date: 10/8/2021 9:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ========================================================
-- Author:		Jon Godwin
-- Create date: 2018-08-06
-- Description:	Updates StoredProcHistory Table
-- ========================================================
ALTER PROCEDURE [dbo].[SprocHxAudit] 

AS
BEGIN
SET NOCOUNT ON;

--Add All Stored Procedures
EXEC master.dbo.sp_foreachdb
'
Use ?
INSERT INTO	[000-WINSRV-RPT].[ITReporting].[dbo].[StoredProcHistory]
(
ServerName
, DatabaseName
, SchemaName
, ObjectName
, CaptureDate
)
(
SELECT	@@SERVERNAME --ServerName
		, DB_NAME() --DatabaseName
		, SCHEMA_NAME(P.schema_id)
		, P.name
		, GETDATE()
FROM	sys.procedures P
WHERE	P.name COLLATE DATABASE_DEFAULT NOT IN 
			(
			SELECT	ObjectName COLLATE DATABASE_DEFAULT 
			FROM	[000-WINSRV-RPT].[ITReporting].[dbo].[StoredProcHistory]
			)
)
'
;

--Update Stored Procedure History
WITH cteSprocUpdate AS
	(
	SELECT	@@SERVERNAME ServerName
			, DB_NAME(DEPS.database_id) DatabaseName
			, OBJECT_SCHEMA_NAME(DEPS.object_id,DEPS.database_id) SchemaName
			, OBJECT_NAME(DEPS.object_id,DEPS.database_id) ObjectName
			, MAX(DEPS.last_execution_time) LastExecution
	FROM	sys.dm_exec_procedure_stats DEPS
	WHERE	DEPS.database_id <> 32767
			AND DEPS.last_execution_time IS NOT NULL
	GROUP BY
			DB_NAME(DEPS.database_id)
			, OBJECT_SCHEMA_NAME(DEPS.object_id,DEPS.database_id)
			, OBJECT_NAME(DEPS.object_id,DEPS.database_id)
	) 

UPDATE	[000-WINSRV-RPT].[ITReporting].[dbo].[StoredProcHistory]
SET		LastExecTime =	CSU.LastExecution
FROM	cteSprocUpdate CSU
WHERE	[StoredProcHistory].Servername = CSU.ServerName
		AND [StoredProcHistory].[DatabaseName] = CSU.DatabaseName
		AND [StoredProcHistory].[SchemaName] = CSU.SchemaName
		AND [StoredProcHistory].[ObjectName] = CSU.ObjectName
;

--Delete Old Stored Procedures From Table
EXEC master.dbo.sp_foreachdb
'
Use ?
DELETE	[000-WINSRV-RPT].[ITReporting].[dbo].[StoredProcHistory]
WHERE	[StoredProcHistory].[ServerName] = @@ServerName
		AND [StoredProcHistory].[DatabaseName] = DB_NAME()
		AND [StoredProcHistory].[SchemaName] = SCHEMA_NAME()
		AND ObjectName COLLATE DATABASE_DEFAULT NOT IN 
					(
					SELECT	P.name COLLATE DATABASE_DEFAULT
					FROM	sys.procedures P
					) 
'
END
