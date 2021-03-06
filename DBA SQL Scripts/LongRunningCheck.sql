USE [master]
GO
/****** Object:  StoredProcedure [dbo].[LongRunningCheck]    Script Date: 10/8/2021 9:55:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-10-09
-- Description:	Checks for Long Running Queries 
--				& Jobs and notifies if any are
--				found.
-- =============================================
CREATE PROCEDURE [dbo].[LongRunningCheck] 
AS
BEGIN
SET NOCOUNT ON;

-- Declare Email Variables
DECLARE	@EmailProfile Varchar(100) = 'DB1 SQL Agent'
DECLARE	@EmailRecp Varchar(150) = 'dbanotifications@pharmaca.com'
DECLARE	@EmailSubject Varchar(MAX)
DECLARE @EmailBody Varchar(MAX)
DECLARE	@Count Int  ;

-- Declare Query Variables
DECLARE @QueryMaxHours Int = 1
DECLARE	@QueryCount Int
DECLARE	@QueryIndex Int
DECLARE @QueryMaxIndex Int
DECLARE @SessionID Varchar(MAX)
DECLARE	@LoginName Varchar(MAX)
DECLARE @HostName Varchar(MAX)
DECLARE @ProgramName Varchar(MAX)
DECLARE @QueryStatus Varchar(MAX)
DECLARE @QueryCommand Varchar(MAX)
DECLARE @QueryStartTime Varchar(MAX)
DECLARE @QueryElapsedTime Varchar(MAX)
DECLARE @PercentComplete Varchar(MAX)
DECLARE	@QueryWaitType Varchar(MAX)
DECLARE	@QueryWaitTime Varchar(MAX)
DECLARE	@QueryCompletionTime Varchar(MAX)
DECLARE @QueryText Varchar(MAX)
DECLARE @Sql NVARCHAR(1000);
;

-- Declare Query Loop Table
DECLARE	@QueryLoopTable Table
(
ID Int IDENTITY(1,1)
, SessionID Varchar(MAX)
, LoginName Varchar(MAX)
, HostName Varchar(MAX)
, ProgramName Varchar(MAX)
, QueryStatus Varchar(MAX)
, QueryCommand Varchar(MAX)
, QueryStartTime Varchar(MAX)
, QueryElapsedTime Varchar(MAX)
, QueryPercentComplete Varchar(MAX)
, QueryWaitType Varchar(MAX)
, QueryWaitTime Varchar(MAX)
, QueryCompletionTime Varchar(MAX)
, QueryText Varchar(MAX)
)
;

-- Declare Job Variables
DECLARE	@JobMaxHours Int = 2
DECLARE	@JobCount Int
DECLARE	@JobIndex Int
DECLARE @JobMaxIndex Int
DECLARE @JobEmailBody Varchar(MAX)
DECLARE	@JobName Varchar(MAX)
DECLARE @JobDesc Varchar(MAX)
DECLARE	@JobStartTime Varchar(MAX)
DECLARE	@JobStepExec Varchar(MAX)
DECLARE	@JobDuration Varchar(MAX)
;

-- Declare Job Loop Table
DECLARE @JobLoopTable Table
(
ID Int IDENTITY(1,1)
, JobName Varchar(MAX)
, JobDesc Varchar(MAX)
, JobStartTime Varchar(MAX)
, JobStepExec Varchar(MAX)
, JobDuration Varchar(MAX)
)
;

-- Populate Query Loop Table
INSERT INTO @QueryLoopTable
(
SessionID
, LoginName
, HostName
, ProgramName
, QueryStatus
, QueryCommand
, QueryStartTime
, QueryElapsedTime
, QueryPercentComplete
, QueryWaitType
, QueryWaitTime
, QueryCompletionTime
, QueryText
)
(
SELECT	ISNULL(R.session_id, '') SessionID
		, UPPER(ISNULL(DES.login_name, '')) LoginName
		, UPPER(ISNULL(DES.host_name, '')) HostName
		, UPPER(ISNULL(DES.program_name, '')) ProgramName
		, UPPER(ISNULL(R.status, '')) QueryStatus
		, UPPER(ISNULL(R.command, '')) QueryCommand
		, ISNULL((CONVERT(Varchar(MAX),CAST(R.start_time AS Date), 101) + ' ' + CONVERT(Varchar(8),CAST(R.start_time AS DateTime),114)), '') StartTime
		, ISNULL((CONVERT(Varchar(MAX), DATEADD(SECOND, (R.total_elapsed_time / 1000), 0), 108)), '')
		, ISNULL(ROUND(R.percent_complete,2), '') PercentComplete
		, UPPER(ISNULL(R.wait_type, '')) WaitType
		, ISNULL((CONVERT(Varchar(MAX), DATEADD(SECOND, (R.wait_time / 1000), 0), 108)),'') WaitTime
		, CASE
			WHEN R.percent_complete IS NULL THEN ''
			WHEN R.total_elapsed_time IS NULL THEN ''
			WHEN R.percent_complete = 0 THEN ''
			WHEN R.total_elapsed_time = 0 THEN ''
			ELSE ISNULL((CONVERT(Varchar(MAX),CAST((DATEADD(s, 100 / ((ISNULL(R.percent_complete, 1)) / (ISNULL(R.total_elapsed_time,1) / 1000)), R.start_time)) AS Date), 101) + ' ' + CONVERT(Varchar(8),CAST((DATEADD(s, 100 / (ISNULL(R.percent_complete, 1) / (ISNULL(R.total_elapsed_time,1) / 1000)), R.start_time)) AS DateTime),114)),'') 
			END AS EstCompletiontime
		, UPPER(ISNULL(ST.text, '')) QueryText
FROM	sys.dm_exec_requests R
CROSS APPLY 
		sys.dm_exec_sql_text(R.sql_handle) ST
LEFT JOIN	
		sys.dm_exec_sessions DES
			ON R.session_id = DES.session_id
WHERE	(((R.total_elapsed_time / 1000) / 60) / 60) >= @QueryMaxHours
		AND UPPER(ISNULL(ST.text, '')) NOT LIKE '%SYS.SP_REPLMONITORREFRESHJOB%'
		AND UPPER(ISNULL(ST.text, '')) NOT LIKE '%SP_MSLOAD_TMP_REPLICATION_STATUS%'
)
;

-- Set @QueryCount
SELECT	@QueryCount = COUNT(*)
FROM	@QueryLoopTable QLT
;

-- Populate Job Loop Table
INSERT INTO @JobLoopTable
(
JobName
, JobDesc
, JobStartTime
, JobStepExec
, JobDuration
)
(
SELECT	CAST(ISNULL(SV.name, '') AS Varchar(MAX))
		, CAST(ISNULL(SV.description, '') AS Varchar(MAX))
		, ISNULL((CONVERT(Varchar(MAX),CAST(S.run_requested_date AS Date), 101) + ' ' + CONVERT(Varchar(8),CAST(S.run_requested_date AS DateTime),114)), '')  StartTime
		, ISNULL(CASE
					WHEN S.last_executed_step_id IS NULL
					THEN 'Step 1 Executing'
					ELSE 'Step ' + CONVERT(Varchar(MAX), S.last_executed_step_id + 1) + ' Executing'
					END
				, '')	
		, ISNULL((CONVERT(Varchar(MAX), DATEADD(SECOND, DATEDIFF(SECOND, S.run_requested_date, GETDATE()), 0), 108)), '')
FROM	msdb.dbo.sysjobs_view SV
INNER JOIN 
		msdb.dbo.sysjobactivity S 
			ON SV.job_id = S.job_id
INNER JOIN	
		msdb.dbo.syssessions S2
			ON S.session_id = S2.session_id
INNER JOIN
		(
		SELECT	MAX(S3.agent_start_date) MaxAgentStartDate
		FROM	msdb.dbo.syssessions S3
		) S3
			ON S2.agent_start_date = S3.MaxAgentStartDate
WHERE	S.run_requested_date IS NOT	NULL
		AND S.stop_execution_date IS NULL
		AND S.run_requested_date >= DATEADD(DAY,-2,CONVERT(Date,GETDATE()))
		AND (DATEDIFF(MINUTE, S.run_requested_date, GETDATE())/60) >= @JobMaxHours
		AND CAST(ISNULL(SV.name, '') AS Varchar(MAX)) <> 'Replication monitoring refresher for distribution.'
		AND SV.job_id <> 'C4683168-9FBE-496F-8738-592F5E55033E'
		AND SV.job_id <> '0BA107B6-CA07-4289-B460-F20A4DFB7405'
		AND	SV.job_id <> 'AF4BE716-0CCF-4FA4-B50A-CCD99ADA94BD'
)
;

-- Set @JobCount
SELECT	@JobCount = COUNT(*)
FROM	@JobLoopTable JLT
;

-- Set @Count
SELECT	@Count = ISNULL(@JobCount,0) + ISNULL(@QueryCount,0)
;

-- Set Email Subjecct
SELECT	@EmailSubject = CAST(ISNULL(@Count,0) AS Varchar(MAX))
						+ CASE
							WHEN ISNULL(@Count,0) = 1 THEN ' Long Running Job or Query Found on '
							ELSE ' Long Running Jobs or Queries Found on '
							END	
						+ CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX)) + ' - ' + FORMAT(GETDATE(), 'MM/dd/yyyy HH:mm')
;

-- Set Email Body Start
SET @EmailBody = '<html><body><table style = "width:100%" bgcolor="ffafad"><tr><td align="center" valign="middle" height="15">'
					+ '<font color="000000" size="3"><b>Long Running '
					+ CASE
						WHEN ISNULL(@JobCount,0) > 0 AND ISNULL(@QueryCount,0) > 0 THEN 'Jobs & Queries Notification'
						WHEN ISNULL(@JobCount,0) <= 0 AND ISNULL(@QueryCount,0) > 0 THEN 'Queries Notification'
						WHEN ISNULL(@JobCount,0) > 0 AND ISNULL(@QueryCount,0) <= 0 THEN 'Jobs Notification'
						ELSE 'Jobs & Queries Notification'
						END
					+ '</b></font></td></tr></table><br>'
;

-- Set the Max Index for Job Loop Table
SELECT	@JobMaxIndex = MAX(JLT.ID)
		, @JobIndex = 1
FROM	@JobLoopTable JLT
;

-- Set Email Header for Long-Running Jobs
-- Set @EmailBody Header
IF ISNULL(@JobMaxIndex,0) < 1 SET @EmailBody = @EmailBody
ELSE SET @EmailBody = @EmailBody + '<font color="#002793" size="2"><b>'
						+ CONVERT(Varchar(MAX), @JobCount) 
						+ CASE
							WHEN @JobCount = 1 THEN ' Long Running Job Found on '
							ELSE ' Long Running Jobs Found on '
							END
						+ CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))
						+ ':</font></b><br>'
;

-- Check The Data
IF ISNULL(@JobMaxIndex,0) < 1
BEGIN
	SET @EmailBody = @EmailBody;
END	
;

-- Iterate Through Job Loop Table
WHILE @JobIndex <= @JobMaxIndex
BEGIN	


SELECT	@JobName = JLT.JobName
		, @JobDesc = JLT.JobDesc
		, @JobStartTime = JLT.JobStartTime
		, @JobStepExec = JLT.JobStepExec
		, @JobDuration = JLT.JobDuration
FROM	@JobLoopTable JLT
WHERE	JLT.ID = @JobIndex
;

-- Format Job Portion of Email
SELECT @EmailBody = @EmailBody + '<table><tr><td valign="top"><b><font size="2" color="#IF3400">Job Name: </b></font></td><td><font size="2">' 
							+ ISNULL(@JobName, '') + '</font></td></tr>' 
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Description: </b></font></td><td><font size="2">' 
							+ ISNULL(@JobDesc, '') + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Start Time: </b></font></td><td><font size="2">' 
							+ ISNULL(@JobStartTime, '') + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Step Exec: </b></font></td><td><font size="2">' 
							+ ISNULL(@JobStepExec, '') + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Duration: </b></font></td><td><font size="2">' 
							+ ISNULL(@JobDuration, '') + '</font></td></tr>' + '</tr></table><br><br>'
;

--  Iterate to the Next Record
SET @JobIndex = @JobIndex + 1
;

END	
;

---- Query Portion of Email
-- Set the Max Index for Query Loop Table
SELECT	@QueryMaxIndex = MAX(QLT.ID)
		, @QueryIndex = 1
FROM	@QueryLoopTable QLT
;

-- Set Email Header for Long-Running Queries
-- Set @EmailBody Header
IF ISNULL(@QueryMaxIndex,0) < 1 SET @EmailBody = @EmailBody
ELSE SET @EmailBody = @EmailBody + '<font color="#002793" size="2"><b>'
						+ CONVERT(Varchar(MAX), @QueryCount) 
						+ CASE
							WHEN @QueryCount = 1 THEN ' Long Running Query Found on '
							ELSE ' Long Running Queries Found on '
							END
						+ CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))
						+ ':</font></b><br>'
;

-- Check The Data
IF ISNULL(@QueryMaxIndex,0) < 1
BEGIN
	SET @EmailBody = @EmailBody;
END	
;

-- Iterate Through Job Loop Table
WHILE @QueryIndex <= @QueryMaxIndex
BEGIN	


SELECT	@SessionID = ISNULL(QLT.SessionID, ' ')
		, @LoginName = ISNULL(QLT.LoginName, ' ')
		, @HostName = ISNULL(QLT.HostName, ' ')
		, @ProgramName = ISNULL(QLT.ProgramName, ' ')
		, @QueryStatus = ISNULL(QLT.QueryStatus, ' ')
		, @QueryCommand = ISNULL(QLT.QueryCommand, ' ')
		, @QueryStartTime = ISNULL(QLT.QueryStartTime, ' ')
		, @QueryElapsedTime = ISNULL(QLT.QueryElapsedTime, ' ') 
		, @PercentComplete = ISNULL(QLT.QueryPercentComplete, '0.00')
		, @QueryWaitType = ISNULL(QLT.QueryWaitType, ' ')
		, @QueryWaitTime = ISNULL(QLT.QueryWaitTime, ' ')
		, @QueryCompletionTime = ISNULL(QLT.QueryCompletionTime, ' ')
		, @QueryText = ISNULL(QLT.QueryText, ' ')
FROM	@QueryLoopTable QLT
WHERE	QLT.ID = @QueryIndex
;

-- Format Query Portion of Email
SELECT @EmailBody = @EmailBody + '<table><tr><td valign="top"><b><font size="2" color="#IF3400">Session: </b></font></td><td><font size="2">' 
							+ @SessionID + '</font></td></tr>' 
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Login: </b></font></td><td><font size="2">' 
							+ @LoginName + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Host: </b></font></td><td><font size="2">' 
							+ @HostName + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Program: </b></font></td><td><font size="2">' 
							+ @ProgramName + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Command: </b></font></td><td><font size="2">' 
							+ @QueryCommand + '</font></td></tr>' 
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Start: </b></font></td><td><font size="2">' 
							+ @QueryStartTime + '</font></td></tr>' 
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Elapsed: </b></font></td><td><font size="2">' 
							+ @QueryElapsedTime + '</font></td></tr>' 							
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">% Compl: </b></font></td><td><font size="2">' 
							+ @PercentComplete + '%</font></td></tr>' 	
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Wait Type: </b></font></td><td><font size="2">' 
							+ @QueryWaitType + '</font></td></tr>' 	
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Wait Time: </b></font></td><td><font size="2">' 
							+ @QueryWaitTime + '</font></td></tr>' 	
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Est Compl: </b></font></td><td><font size="2">' 
							+ @QueryCompletionTime + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Query: </b></font></td><td><font size="2">' 
							+ @QueryText + '</font></td></tr>'
							+ '</tr></table><br><br>'
;

-- Kill the query if it's coming from office
IF CHARINDEX('OFFICE',@ProgramName)>0
BEGIN
    SET @Sql = 'KILL ' + @SessionID;
    BEGIN TRY
	   EXEC (@Sql);
    END TRY
    BEGIN CATCH
	   -- Do nothing
    END CATCH
END

--  Iterate to the Next Record
SET @QueryIndex = @QueryIndex + 1
;

END	
;

-- Set Close of Email Body
SET @EmailBody = @EmailBody + '</body></html>'
;

-- Email Results
IF @Count >= 1
BEGIN
    
EXEC msdb.dbo.sp_send_dbmail
@profile_name = @EmailProfile
, @body = @EmailBody
, @body_format = 'HTML'
, @recipients =	@EmailRecp
, @subject = @EmailSubject
;
END

END
