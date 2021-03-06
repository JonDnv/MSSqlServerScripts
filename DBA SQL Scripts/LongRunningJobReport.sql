USE [master]
GO
/****** Object:  StoredProcedure [dbo].[LongRunningJobReport]    Script Date: 10/8/2021 9:55:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-10-08
-- Description:	Reports on Any Jobs that Ran Over
--				2 Standard Deviations More than the
--				average for the job.
-- =============================================
CREATE PROCEDURE [dbo].[LongRunningJobReport]	 
AS
BEGIN
SET NOCOUNT ON;

-- Email Variables
DECLARE	@EmailProfile Varchar(50) = 'DB1 SQL Agent'
DECLARE @EmailRecp Varchar(150) = 'dbanotifications@pharmaca.com'
DECLARE @EmailSubject Varchar(MAX)
DECLARE @EmailBody Varchar(MAX)
DECLARE @Count Int
;

-- Script Variables
DECLARE @HistoryStartDate datetime = '19000101'
DECLARE	@HistoryEndDate DateTime = GETDATE()
DECLARE	@MinHistExecutions Int = 5 -- 5 Execution for Baseline
DECLARE @MinAvgSecsDuration Int = 1800 -- Only Looks At Jobs that Usually Run Over 30 Minutes
;

-- Declare Job Variables
DECLARE @JobID Varchar(MAX)
DECLARE @JobName Varchar(MAX)
DECLARE @JobDesc Varchar(MAX)
DECLARE @DateExecuted Varchar(MAX)
DECLARE @AvgDuration Varchar(MAX)
DECLARE @AvgPlus2StdDev Varchar(MAX)
DECLARE @SecondsDuration Varchar(MAX)
DECLARE @JobIndex Int
DECLARE	@JobMaxIndex Int
;

-- Declare Job Loop Table
DECLARE	@JobLoopTable Table
(
ID Int IDENTITY(1,1) NOT NULL
, JobID Varchar(MAX) NOT NULL	
, JobName Varchar(MAX) NOT NULL
, JobDescription Varchar(MAX) NOT NULL
, DateExecuted Varchar(MAX) NOT NULL
, AvgDuration Varchar(MAX) NOT NULL	
, AvgPlus2StdDev Varchar(MAX) NOT NULL	
, SecondsDuration Varchar(MAX) NOT NULL	
)
;

-- Populate Loop Table
WITH JobHistData AS
(
SELECT	job_id
		, msdb.dbo.agent_datetime(run_date, run_time) date_executed
		, run_duration/10000*3600 + run_duration%10000/100*60 + run_duration%100 secs_duration
FROM	msdb.dbo.sysjobhistory
WHERE	step_id = 0   --Job Outcome
		AND run_status = 1  --Succeeded
)

,

JobHistStats AS
(
SELECT	job_id
        , AVG(secs_duration*1.) AvgDuration
        , AVG(secs_duration*1.) + 2*stdevp(secs_duration) AvgPlus2StDev
FROM	JobHistData
WHERE	date_executed >= DATEADD(day, DATEDIFF(day,'19000101',@HistoryStartDate),'19000101')
		AND date_executed < DATEADD(day, 1 + DATEDIFF(day,'19000101',@HistoryEndDate),'19000101') 
GROUP BY 
		job_id HAVING COUNT(*) >= @MinHistExecutions
		AND AVG(secs_duration*1.) >= @MinAvgSecsDuration
)

INSERT INTO @JobLoopTable
(
JobID
, JobName
, JobDescription
, DateExecuted
, AvgDuration
, AvgPlus2StdDev
, SecondsDuration
)

SELECT	JD.job_id
		, S2.name
		, S2.description
		, CONVERT(Varchar(MAX), JD.date_executed, 101) + ' ' + CONVERT(Varchar(MAX), JD.date_executed, 108)
		, CONVERT(Varchar(MAX), DATEADD(SECOND, JS.AvgDuration, 0), 108)
		, CONVERT(Varchar(MAX), DATEADD(SECOND, JS.AvgPlus2StDev, 0), 108)
		, CONVERT(Varchar(MAX), DATEADD(SECOND, MAX(JD.secs_duration), 0), 108) 
FROM	JobHistData JD
INNER JOIN
		JobHistStats JS
			ON JD.job_id = JS.job_id
INNER JOIN	
		msdb.dbo.sysjobactivity S 
			ON JD.job_id = S.job_id
INNER JOIN	
		msdb.dbo.sysjobs S2
			ON JD.job_id = S2.job_id
INNER JOIN	
		msdb.dbo.sysjobsteps S3
			ON JD.job_id = S3.job_id
			AND S.last_executed_step_id = S3.step_id
WHERE	JD.secs_duration > JS.AvgPlus2StDev
		AND S.start_execution_date IS NOT NULL
		AND JD.date_executed >= DATEADD(HOUR,-24,GETDATE())
		AND S2.job_id <> 'C4683168-9FBE-496F-8738-592F5E55033E'
		AND S2.job_id <> '0BA107B6-CA07-4289-B460-F20A4DFB7405'
		AND S2.job_id <> 'AF4BE716-0CCF-4FA4-B50A-CCD99ADA94BD'
GROUP BY
		JD.job_id
		, S2.name
		, S2.description
		, JD.date_executed
		, JS.AvgDuration
		, JS.AvgPlus2StDev
;

-- Set @Count
SELECT	@Count = ISNULL(COUNT(*),0)
FROM	@JobLoopTable
;

-- Set @EmailSubject
SELECT @EmailSubject = 'Long Running Jobs Report | ' + CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX)) + ' | ' + FORMAT(DATEADD(DAY,-1,GETDATE()), 'MM/dd/yyyy')
;

-- Set @EmailBody Start
SELECT	@EmailBody = '<html><body><table style="width:100%" bgcolor="00a0ad"><tr><td align="center" valign="middle" height="15">'
						+ '<font color="ffffff" size="4"><b>Long-Running Jobs Report</b></font></td></tr></table><br>'
;

-- Set the Max Index for Job Loop Table
SELECT	@JobMaxIndex = MAX(JLT.ID)
		, @JobIndex = 1
FROM	@JobLoopTable JLT
;

-- Set @EmailBody Header
IF ISNULL(@JobMaxIndex,0) < 1 SET @EmailBody = @EmailBody
ELSE SET @EmailBody = @EmailBody + '<font color="#002793"><b>'
						+ CONVERT(Varchar(MAX), @Count) 
						+ CASE
							WHEN @Count = 1 THEN ' Long Running Job Found on '
							ELSE ' Long Running Jobs Found on '
							END
						+ CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))
						+ ':</font></b><br>'
;

-- Check The Data
IF ISNULL(@JobMaxIndex,0) < 1
BEGIN
	RETURN;
END	

-- Iterate Through Job Loop Table
WHILE @JobIndex <= @JobMaxIndex
BEGIN	

SELECT	@JobID = JLT.JobID
		, @JobName = JLT.JobName
		, @JobDesc = JLT.JobDescription
		, @DateExecuted = JLT.DateExecuted
		, @AvgDuration = JLT.AvgDuration
		, @AvgPlus2StdDev = JLT.AvgPlus2StdDev
		, @SecondsDuration = JLT.SecondsDuration
FROM	@JobLoopTable JLT
WHERE	JLT.ID = @JobIndex
;

-- Format Job Portion of Email
SELECT @EmailBody = @EmailBody + '<table><tr><td valign="top"><b><font size="2" color="#IF3400">Job: </b></font></td><td><font size="2">' 
							+ @JobName + '</font></td></tr>' 
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Job ID: </b></font></td><td><font size="2">' 
							+ @JobID + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Exec Date: </b></font></td><td><font size="2">' 
							+ @DateExecuted + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Avg Dur: </b></font></td><td><font size="2">' 
							+ @AvgDuration + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Threshold: </b></font></td><td><font size="2">' 
							+ @AvgPlus2StdDev + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">This Exec: </b></font></td><td><font size="2">' 
							+ @SecondsDuration + '</font></td></tr>' + '</tr></table><br><br>'


--  Iterate to the Next Record
SET @JobIndex = @JobIndex + 1
;

END	
;

-- End @EmailBody
SET	@EmailBody = @EmailBody + '</body></html>'

-- Email Results
IF @Count >= 1
BEGIN	
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = @EmailProfile
		, @recipients = @EmailRecp
		, @subject = @EmailSubject
		, @body = @EmailBody
		, @body_format = 'HTML'
;

END	
;	

END
