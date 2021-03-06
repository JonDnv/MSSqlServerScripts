USE [master]
GO
/****** Object:  StoredProcedure [dbo].[JobHxAudit]    Script Date: 10/8/2021 9:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ======================================
-- Author:		Jon Godwin
-- Create date: 2018-08-06
-- Description:	Updates JobHistory Table
-- ======================================
CREATE PROCEDURE [dbo].[JobHxAudit] 
AS
BEGIN
SET NOCOUNT ON;

--Add All Jobs to Table
INSERT INTO [000-WINSRV-RPT].[ITReporting].[dbo].[JobHistory]
		(
		ServerName
		, JobName
		, JobEnabled
		, JobOwner
		, RunDate
		, RunTime
		)
SELECT	@@SERVERNAME ServerName
		, S.name JobName
		, S.enabled JobEnabled
		, SUSER_SNAME(S.owner_sid) JobOwner
		, CONVERT(Date,CONVERT(Varchar(10),MAX(S2.run_date),101))
		, CONVERT(Time,(STUFF(STUFF(RIGHT(REPLICATE('0', 6) +  CAST(MAX(S2.run_time) AS Varchar(6)), 6), 3, 0, ':'), 6, 0, ':'))) RunTime
FROM	msdb.dbo.sysjobs S 
LEFT JOIN 
		msdb.dbo.sysjobhistory S2
			ON S.job_id = S2.job_id
WHERE	@@SERVERNAME NOT IN (SELECT ServerName FROM [000-WINSRV-RPT].[ITReporting].[dbo].[JobHistory])
		AND S.name NOT IN (SELECT JobName FROM [000-WINSRV-RPT].[ITReporting].[dbo].[JobHistory])
GROUP BY
		S.name
		, S.enabled
		, SUSER_SNAME(S.owner_sid)
;

--Update JobHistory Table
UPDATE	[000-WINSRV-RPT].[ITReporting].[dbo].[JobHistory]
SET		JobEnabled =	(
						SELECT	S.enabled
						FROM	msdb.dbo.sysjobs S 
						WHERE	@@SERVERNAME = ServerName
								AND S.name = JobName
								AND S.enabled IS NOT NULL
						)
		, JobOwner =	(
						SELECT	SUSER_SNAME(S2.owner_sid)
						FROM	msdb.dbo.sysjobs S2 
						WHERE	@@SERVERNAME = ServerName
								AND S2.name = JobName
								AND s2.name IS NOT NULL
						)
		, RunDate =		(
						SELECT	CONVERT(Date,CONVERT(Varchar(10),MAX(S2.run_date),101))
						FROM	msdb.dbo.sysjobs S 
						LEFT JOIN 
								msdb.dbo.sysjobhistory S2
									ON S.job_id = S2.job_id
						WHERE	@@SERVERNAME = ServerName
								AND S.name = JobName
								AND S2.run_date IS NOT NULL	
						)
		, RunTime =		(
						SELECT	CONVERT(Time,(STUFF(STUFF(RIGHT(REPLICATE('0', 6) 
									+ CAST(MAX(S2.run_time) AS Varchar(6)), 6), 3, 0, ':'), 6, 0, ':'))) RunTime
						FROM	msdb.dbo.sysjobs S 
						LEFT JOIN 
								msdb.dbo.sysjobhistory S2
									ON S.job_id = S2.job_id
						WHERE	@@SERVERNAME = ServerName
								AND S.name = JobName
								AND S2.run_time IS NOT NULL	
						)
;

--Delete Old Jobs From Table
DELETE	[000-WINSRV-RPT].[ITReporting].[dbo].[JobHistory]
WHERE	ServerName = @@SERVERNAME
		AND JobName NOT IN	
		(
		SELECT	S.name
		FROM	msdb.dbo.sysjobs S
		)


END
