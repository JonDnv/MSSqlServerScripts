USE [master]
GO

/****** Object:  Table [dbo].[sql_server_agent_job]    Script Date: 10/8/2021 9:57:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sql_server_agent_job](
	[sql_server_agent_job_id] [Int] IDENTITY(1,1) NOT NULL,
	[sql_server_agent_job_id_guid] [UniqueIdentifier] NOT NULL,
	[sql_server_agent_job_name] [NVarchar](128) NOT NULL,
	[job_create_datetime_utc] [DateTime] NOT NULL,
	[job_last_modified_datetime_utc] [DateTime] NOT NULL,
	[is_enabled] [Bit] NOT NULL,
	[is_deleted] [Bit] NOT NULL,
	[job_category_name] [Varchar](100) NOT NULL,
 CONSTRAINT [PK_sql_server_agent_job] PRIMARY KEY CLUSTERED 
(
	[sql_server_agent_job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [master]
GO

/****** Object:  Table [dbo].[sql_server_agent_job_failure]    Script Date: 10/8/2021 9:57:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sql_server_agent_job_failure](
	[sql_server_agent_job_failure_id] [Int] IDENTITY(1,1) NOT NULL,
	[sql_server_agent_job_id] [Int] NOT NULL,
	[sql_server_agent_instance_id] [Int] NOT NULL,
	[job_start_time_utc] [DateTime] NOT NULL,
	[job_failure_time_utc] [DateTime] NOT NULL,
	[job_failure_step_number] [SmallInt] NOT NULL,
	[job_failure_step_name] [Varchar](250) NOT NULL,
	[job_failure_message] [Varchar](MAX) NOT NULL,
	[job_step_failure_message] [Varchar](MAX) NOT NULL,
	[job_step_severity] [Int] NOT NULL,
	[job_step_message_id] [Int] NOT NULL,
	[retries_attempted] [Int] NOT NULL,
	[has_email_been_sent_to_operator] [Bit] NOT NULL,
 CONSTRAINT [PK_sql_server_agent_job_failure] PRIMARY KEY CLUSTERED 
(
	[sql_server_agent_job_failure_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[sql_server_agent_job_failure]  WITH CHECK ADD  CONSTRAINT [FK_sql_server_agent_job_failure_sql_server_agent_job] FOREIGN KEY([sql_server_agent_job_id])
REFERENCES [dbo].[sql_server_agent_job] ([sql_server_agent_job_id])
GO

ALTER TABLE [dbo].[sql_server_agent_job_failure] CHECK CONSTRAINT [FK_sql_server_agent_job_failure_sql_server_agent_job]
GO


USE [master]
GO
/****** Object:  StoredProcedure [dbo].[monitor_job_failures]    Script Date: 10/8/2021 9:55:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[monitor_job_failures]

@minutes_to_monitor Smallint = 1440

AS
BEGIN
SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#job_step_failure') IS NOT NULL DROP TABLE #job_step_failure;
IF OBJECT_ID('tempdb..#job_failure') IS NOT NULL DROP TABLE #job_failure;

-- Determine UTC offset so that all times can easily be converted to UTC.
DECLARE @utc_offset Int;

SELECT	@utc_offset = -1 * DATEDIFF(HOUR, GETUTCDATE(), GETDATE());

-- First, collect list of SQL Server agent jobs and update ours as needed.
-- Update our jobs data with any changes since the last update time.
MERGE INTO dbo.sql_server_agent_job TARGET
USING	(
		SELECT	sysjobs.job_id sql_server_agent_job_id_guid
				, sysjobs.name sql_server_agent_job_name
				, sysjobs.date_created job_create_datetime_utc
				, sysjobs.date_modified job_last_modified_datetime_utc
				, sysjobs.enabled is_enabled
				, 0 is_deleted
				, ISNULL(syscategories.name, '') job_category_name
		FROM	msdb.dbo.sysjobs
		LEFT JOIN
				msdb.dbo.syscategories
					ON syscategories.category_id = sysjobs.category_id
		) SOURCE
ON		(SOURCE.sql_server_agent_job_id_guid = TARGET.sql_server_agent_job_id_guid)
WHEN NOT MATCHED BY TARGET THEN
INSERT
	(
	sql_server_agent_job_id_guid
	, sql_server_agent_job_name
	, job_create_datetime_utc
	, job_last_modified_datetime_utc
	, is_enabled
	, is_deleted
	, job_category_name
	)
	VALUES
	(
	SOURCE.sql_server_agent_job_id_guid
	, SOURCE.sql_server_agent_job_name
	, SOURCE.job_create_datetime_utc
	, SOURCE.job_last_modified_datetime_utc
	, SOURCE.is_enabled
	, SOURCE.is_deleted
	, SOURCE.job_category_name
	)
WHEN MATCHED AND SOURCE.job_last_modified_datetime_utc > TARGET.job_last_modified_datetime_utc 
THEN
UPDATE SET	sql_server_agent_job_name = SOURCE.sql_server_agent_job_name
			, job_create_datetime_utc = SOURCE.job_create_datetime_utc
			, job_last_modified_datetime_utc = SOURCE.job_last_modified_datetime_utc
			, is_enabled = SOURCE.is_enabled
			, is_deleted = SOURCE.is_deleted
			, job_category_name = SOURCE.job_category_name;

-- If a job was deleted, then mark it as no longer enabled.
UPDATE	sql_server_agent_job
SET		is_enabled = 0
		, is_deleted = 1
FROM	dbo.sql_server_agent_job
LEFT JOIN
		msdb.dbo.sysjobs
			ON sysjobs.Job_Id = sql_server_agent_job.sql_server_agent_job_id_guid
WHERE	sysjobs.Job_Id IS NULL;

-- Find all recent job failures and log them in the target log table.
WITH CTE_NORMALIZE_DATETIME_DATA AS
		(
		SELECT	sysjobhistory.job_id sql_server_agent_job_id_guid
		, CAST(sysjobhistory.run_date AS Varchar(MAX)) run_date_string
		, REPLICATE('0', 6 - LEN(CAST(sysjobhistory.run_time AS Varchar(MAX)))) + CAST(sysjobhistory.run_time AS Varchar(MAX)) run_time_string
		, REPLICATE('0', 6 - LEN(CAST(sysjobhistory.run_duration AS Varchar(MAX)))) + CAST(sysjobhistory.run_duration AS Varchar(MAX)) run_duration_string
		, sysjobhistory.run_status
		, sysjobhistory.message
		, sysjobhistory.instance_id
FROM	msdb.dbo.sysjobhistory WITH (NOLOCK)
WHERE	sysjobhistory.run_status = 0
		AND sysjobhistory.step_id = 0
		)
		, CTE_GENERATE_DATETIME_DATA AS
			(
			SELECT	CTE_NORMALIZE_DATETIME_DATA.sql_server_agent_job_id_guid
					, CAST(SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_date_string, 5, 2) + '/' + SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_date_string, 7, 2) + '/' + SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_date_string, 1, 4) AS DateTime) + CAST(STUFF(STUFF(CTE_NORMALIZE_DATETIME_DATA.run_time_string, 5, 0, ':'), 3, 0, ':') AS DateTime) job_start_datetime
					, CAST(SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_duration_string, 1, 2) AS Int) * 3600 + CAST(SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_duration_string, 3, 2) AS Int) * 60 + CAST(SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_duration_string, 5, 2) AS Int)job_duration_seconds
					, CASE CTE_NORMALIZE_DATETIME_DATA.run_status
						WHEN 0 THEN 'Failure'
						WHEN 1 THEN 'Success'
						WHEN 2 THEN 'Retry'
						WHEN 3 THEN 'Canceled'
						ELSE 'Unknown'
						END job_status
					, CTE_NORMALIZE_DATETIME_DATA.message
					, CTE_NORMALIZE_DATETIME_DATA.instance_id
			FROM	CTE_NORMALIZE_DATETIME_DATA
			)
SELECT	CTE_GENERATE_DATETIME_DATA.sql_server_agent_job_id_guid
		, DATEADD(HOUR, @utc_offset, CTE_GENERATE_DATETIME_DATA.job_start_datetime) job_start_time_utc
		, DATEADD(HOUR, @utc_offset, DATEADD(SECOND, ISNULL(CTE_GENERATE_DATETIME_DATA.job_duration_seconds, 0)
		, CTE_GENERATE_DATETIME_DATA.job_start_datetime)) job_failure_time_utc
		, ISNULL(CTE_GENERATE_DATETIME_DATA.message, '') job_failure_message
		, CTE_GENERATE_DATETIME_DATA.instance_id
INTO	#job_failure
FROM	CTE_GENERATE_DATETIME_DATA
WHERE	DATEADD(HOUR, @utc_offset, CTE_GENERATE_DATETIME_DATA.job_start_datetime) > DATEADD(MINUTE, -1 * @minutes_to_monitor, GETUTCDATE())
;

WITH CTE_NORMALIZE_DATETIME_DATA AS
	(
	SELECT	sysjobhistory.job_id sql_server_agent_job_id_guid
			, CAST(sysjobhistory.run_date AS Varchar(MAX)) run_date_string
			, REPLICATE('0', 6 - LEN(CAST(sysjobhistory.run_time AS Varchar(MAX)))) + CAST(sysjobhistory.run_time AS Varchar(MAX)) run_time_string
			, REPLICATE('0', 6 - LEN(CAST(sysjobhistory.run_duration AS Varchar(MAX)))) + CAST(sysjobhistory.run_duration AS Varchar(MAX)) run_duration_string
			, sysjobhistory.run_status
			, sysjobhistory.step_id
			, sysjobhistory.step_name
			, sysjobhistory.message
			, sysjobhistory.retries_attempted
			, sysjobhistory.sql_severity
			, sysjobhistory.sql_message_id
			, sysjobhistory.instance_id
	FROM	msdb.dbo.sysjobhistory WITH (NOLOCK)
	WHERE	sysjobhistory.run_status = 0
			AND sysjobhistory.step_id > 0
	)
	, CTE_GENERATE_DATETIME_DATA AS
	(
	SELECT	CTE_NORMALIZE_DATETIME_DATA.sql_server_agent_job_id_guid
			, CAST(SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_date_string, 5, 2) + '/' + SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_date_string, 7, 2) + '/' + SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_date_string, 1, 4) AS DateTime) + CAST(STUFF(STUFF(CTE_NORMALIZE_DATETIME_DATA.run_time_string, 5, 0, ':'), 3, 0, ':') AS DateTime) job_start_datetime
			, CAST(SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_duration_string, 1, 2) AS Int) * 3600 + CAST(SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_duration_string, 3, 2) AS Int) * 60 + CAST(SUBSTRING(CTE_NORMALIZE_DATETIME_DATA.run_duration_string, 5, 2) AS Int) job_duration_seconds
			, CASE CTE_NORMALIZE_DATETIME_DATA.run_status
				WHEN 0 THEN 'Failure'
				WHEN 1 THEN 'Success'
				WHEN 2 THEN 'Retry'
				WHEN 3 THEN 'Canceled'
				ELSE 'Unknown'
				END job_status
			, CTE_NORMALIZE_DATETIME_DATA.step_id
			, CTE_NORMALIZE_DATETIME_DATA.step_name
			, CTE_NORMALIZE_DATETIME_DATA.message
			, CTE_NORMALIZE_DATETIME_DATA.retries_attempted
			, CTE_NORMALIZE_DATETIME_DATA.sql_severity
			, CTE_NORMALIZE_DATETIME_DATA.sql_message_id
			, CTE_NORMALIZE_DATETIME_DATA.instance_id
	FROM	CTE_NORMALIZE_DATETIME_DATA
	)
SELECT	CTE_GENERATE_DATETIME_DATA.sql_server_agent_job_id_guid
		, DATEADD(HOUR, @utc_offset, CTE_GENERATE_DATETIME_DATA.job_start_datetime) job_start_time_utc
		, DATEADD(HOUR, @utc_offset, DATEADD(SECOND, ISNULL(CTE_GENERATE_DATETIME_DATA.job_duration_seconds, 0)
		, CTE_GENERATE_DATETIME_DATA.job_start_datetime)
		) job_failure_time_utc
		, CTE_GENERATE_DATETIME_DATA.step_id job_failure_step_number
		, ISNULL(CTE_GENERATE_DATETIME_DATA.message, '') job_step_failure_message
		, CTE_GENERATE_DATETIME_DATA.sql_severity job_step_severity
		, CTE_GENERATE_DATETIME_DATA.retries_attempted
		, CTE_GENERATE_DATETIME_DATA.step_name
		, CTE_GENERATE_DATETIME_DATA.sql_message_id
		, CTE_GENERATE_DATETIME_DATA.instance_id
INTO	#job_step_failure
FROM	CTE_GENERATE_DATETIME_DATA
WHERE	DATEADD(HOUR, @utc_offset, CTE_GENERATE_DATETIME_DATA.job_start_datetime) > DATEADD(MINUTE, -1 * @minutes_to_monitor, GETUTCDATE())
;

-- Get jobs that failed due to failed steps.
WITH CTE_FAILURE_STEP AS
	(
	SELECT	*
			, ROW_NUMBER() OVER (PARTITION BY job_step_failure.sql_server_agent_job_id_guid
											, job_step_failure.job_failure_time_utc
								ORDER BY	job_step_failure.job_failure_step_number DESC
								)	recent_step_rank
	FROM	#job_step_failure job_step_failure
	)
INSERT INTO dbo.sql_server_agent_job_failure
	(
	sql_server_agent_job_id
	, sql_server_agent_instance_id
	, job_start_time_utc
	, job_failure_time_utc
	, job_failure_step_number
	, job_failure_step_name
	, job_failure_message
	, job_step_failure_message
	, job_step_severity
	, job_step_message_id
	, retries_attempted
	, has_email_been_sent_to_operator
	)
SELECT	sql_server_agent_job.sql_server_agent_job_id
		, CTE_FAILURE_STEP.instance_id
		, job_failure.job_start_time_utc
		, CTE_FAILURE_STEP.job_failure_time_utc
		, CTE_FAILURE_STEP.job_failure_step_number
		, CTE_FAILURE_STEP.step_name job_failure_step_name
		, job_failure.job_failure_message
		, CTE_FAILURE_STEP.job_step_failure_message
		, CTE_FAILURE_STEP.job_step_severity
		, CTE_FAILURE_STEP.sql_message_id job_step_message_id
		, CTE_FAILURE_STEP.retries_attempted
		, 0 has_email_been_sent_to_operator
FROM	#job_failure job_failure
INNER JOIN
		dbo.sql_server_agent_job
			ON job_failure.sql_server_agent_job_id_guid = sql_server_agent_job.sql_server_agent_job_id_guid

INNER JOIN
		CTE_FAILURE_STEP
			ON	job_failure.sql_server_agent_job_id_guid = CTE_FAILURE_STEP.sql_server_agent_job_id_guid
				AND job_failure.job_failure_time_utc = CTE_FAILURE_STEP.job_failure_time_utc
WHERE	CTE_FAILURE_STEP.recent_step_rank = 1
		AND CTE_FAILURE_STEP.instance_id NOT IN (
												SELECT	sql_server_agent_job_failure.sql_server_agent_instance_id
												FROM	dbo.sql_server_agent_job_failure
												);

-- Get jobs that failed without any failed steps.
INSERT INTO dbo.sql_server_agent_job_failure
	(
	sql_server_agent_job_id
	, sql_server_agent_instance_id
	, job_start_time_utc
	, job_failure_time_utc
	, job_failure_step_number
	, job_failure_step_name
	, job_failure_message
	, job_step_failure_message
	, job_step_severity
	, job_step_message_id
	, retries_attempted
	, has_email_been_sent_to_operator
	)
SELECT	sql_server_agent_job.sql_server_agent_job_id
		, job_failure.instance_id
		, job_failure.job_start_time_utc
		, job_failure.job_failure_time_utc
		, 0	job_failure_step_number
		, '' job_failure_step_name
		, job_failure.job_failure_message
		, '' job_step_failure_message
		, -1 job_step_severity
		, -1 job_step_message_id
		, 0 retries_attempted
		, 0 has_email_been_sent_to_operator
FROM	#job_failure job_failure
INNER JOIN
		dbo.sql_server_agent_job
			ON job_failure.sql_server_agent_job_id_guid = sql_server_agent_job.sql_server_agent_job_id_guid
WHERE	job_failure.instance_id NOT IN	(
										SELECT	sql_server_agent_job_failure.sql_server_agent_instance_id
										FROM	dbo.sql_server_agent_job_failure
										)
		AND NOT EXISTS	(
						SELECT	*
						FROM	#job_step_failure job_step_failure
						WHERE	job_failure.sql_server_agent_job_id_guid = job_step_failure.sql_server_agent_job_id_guid
								AND job_failure.job_failure_time_utc = job_step_failure.job_failure_time_utc
						)
;

-- Get job steps that failed, but for jobs that succeeded.
WITH CTE_FAILURE_STEP AS
	(
	SELECT	*
			, ROW_NUMBER() OVER (
								PARTITION BY job_step_failure.sql_server_agent_job_id_guid
											, job_step_failure.job_failure_time_utc
								ORDER BY	job_step_failure.job_failure_step_number DESC
								) recent_step_rank
	FROM	#job_step_failure job_step_failure
	)
INSERT INTO dbo.sql_server_agent_job_failure
	(
	sql_server_agent_job_id
	, sql_server_agent_instance_id
	, job_start_time_utc
	, job_failure_time_utc
	, job_failure_step_number
	, job_failure_step_name
	, job_failure_message
	, job_step_failure_message
	, job_step_severity
	, job_step_message_id
	, retries_attempted
	, has_email_been_sent_to_operator
	)
SELECT	sql_server_agent_job.sql_server_agent_job_id
		, CTE_FAILURE_STEP.instance_id
		, CTE_FAILURE_STEP.job_start_time_utc
		, CTE_FAILURE_STEP.job_failure_time_utc
		, CTE_FAILURE_STEP.job_failure_step_number
		, CTE_FAILURE_STEP.step_name job_failure_step_name
		, '' job_failure_message
		, CTE_FAILURE_STEP.job_step_failure_message
		, CTE_FAILURE_STEP.job_step_severity
		, CTE_FAILURE_STEP.sql_message_id job_step_message_id
		, CTE_FAILURE_STEP.retries_attempted
		, 0 has_email_been_sent_to_operator
FROM	CTE_FAILURE_STEP
INNER JOIN
		dbo.sql_server_agent_job
			ON CTE_FAILURE_STEP.sql_server_agent_job_id_guid = sql_server_agent_job.sql_server_agent_job_id_guid

LEFT JOIN
		#job_failure job_failure
			ON	job_failure.sql_server_agent_job_id_guid = CTE_FAILURE_STEP.sql_server_agent_job_id_guid
				AND job_failure.job_failure_time_utc = CTE_FAILURE_STEP.job_failure_time_utc
WHERE	CTE_FAILURE_STEP.recent_step_rank = 1
		AND job_failure.sql_server_agent_job_id_guid IS NULL
		AND CTE_FAILURE_STEP.instance_id NOT IN (
												SELECT	sql_server_agent_job_failure.sql_server_agent_instance_id
												FROM	dbo.sql_server_agent_job_failure
												);

DECLARE @profile_name Varchar(MAX) = 'DB1 SQL Agent';
DECLARE @email_to_address Varchar(MAX) = 'dbanotifications@pharmaca.com';
DECLARE @email_subject Varchar(MAX);
DECLARE @email_body Varchar(MAX);
DECLARE @job_failure_count Int;

SELECT	@job_failure_count	= COUNT(*)
FROM	dbo.sql_server_agent_job_failure
WHERE	sql_server_agent_job_failure.has_email_been_sent_to_operator = 0;

-- Email Results
-- Set Email HTML Start
SELECT	@email_body =	'<html><body><table style="width:100%" bgcolor="953600"><tr><td align="center" valign="middle" height="15">'
						+ '<font color="ffffff" size="4"><b>Failed Job Notification</b></font></td></tr></table><br>' + 
						CASE 
							WHEN @job_failure_count = 1 
								THEN '<font color="#4d0023"><b>' + CAST(@job_failure_count AS Varchar(MAX))
									+ ' Job Has Failed On ' + ISNULL(@@SERVERNAME, CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))) 
									+ ':</b></font><br><br>'
								ELSE '<html><body><font color="#4d0023"><b>' + CAST(@job_failure_count AS Varchar(MAX)) 
									+ ' Jobs Have Failed On ' + ISNULL(@@SERVERNAME, CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))) 
									+ ':</b></font><br><br>' 
						END

-- Declare Loop Table & Parameters
DECLARE	@LoopTable Table 
			(
			ID Int IDENTITY(1,1)
			, JobName Varchar(MAX)
			, JobStartTimeLocal Varchar(MAX)
			, JobFailureTimeLocal Varchar(MAX)
			, JobStepFailureName Varchar(MAX)
			, JobFailureMessage Varchar(MAX)
			, JobStepFailureMessage Varchar(MAX)
			)
;

DECLARE	@Index Int
		, @MaxIndex Int
		, @JobName Varchar(MAX)
		, @JobStartTimeLocal Varchar(MAX)
		, @JobFailureTimeLocal Varchar(MAX)
		, @JobStepFailureName Varchar(MAX)
		, @JobFailureMessage Varchar(MAX)
		, @JobStepFailureMessage Varchar(MAX)
		, @FailedJobEmail Varchar(MAX)
;

-- Populate Loop Table
INSERT @LoopTable
(
JobName
, JobStartTimeLocal
, JobFailureTimeLocal
, JobStepFailureName
, JobFailureMessage
, JobStepFailureMessage
)
(
SELECT	CAST(sql_server_agent_job.sql_server_agent_job_name AS Varchar(MAX)) JobName
		, CONVERT(Varchar(MAX), DATEADD(HOUR, -1 * @utc_offset, sql_server_agent_job_failure.job_start_time_utc), 101) 
				+ ' ' + CONVERT(Varchar(MAX), DATEADD(HOUR, -1 * @utc_offset, sql_server_agent_job_failure.job_start_time_utc), 108) JobStartTimeLocal
		, CONVERT(Varchar(MAX), DATEADD(HOUR, -1 * @utc_offset, sql_server_agent_job_failure.job_failure_time_utc),101) 
				+ ' ' + CONVERT(Varchar(MAX), DATEADD(HOUR, -1 * @utc_offset, sql_server_agent_job_failure.job_failure_time_utc),108) JobFailureTimeLocal
		, sql_server_agent_job_failure.job_failure_step_name JobStepFailureName
		, sql_server_agent_job_failure.job_failure_message JobFailureMessage
		, sql_server_agent_job_failure.job_step_failure_message	JobStepFailureMessage
FROM	dbo.sql_server_agent_job_failure
INNER JOIN
		dbo.sql_server_agent_job
			ON sql_server_agent_job.sql_server_agent_job_id = sql_server_agent_job_failure.sql_server_agent_job_id
WHERE	sql_server_agent_job_failure.has_email_been_sent_to_operator = 0
)

-- Determine Max Value, Set Iterator
SELECT	@MaxIndex = MAX(LT.ID) 
		, @Index = 1
FROM	@LoopTable LT;

-- Check The Data
IF ISNULL(@MaxIndex,0) < 1
BEGIN	
	RETURN;
END	

-- Start The Loop
WHILE @Index <= @MaxIndex
BEGIN	

-- Get the Values from the Loop Table
SELECT	@JobName = LT.JobName
		, @JobStartTimeLocal = LT.JobStartTimeLocal
		, @JobFailureTimeLocal = LT.JobFailureTimeLocal
		, @JobStepFailureName = LT.JobStepFailureName
		, @JobFailureMessage = LT.JobFailureMessage
		, @JobStepFailureMessage = LT.JobStepFailureMessage
FROM	@LoopTable LT WHERE LT.ID = @Index
;

--Format Email
SELECT	@email_body = @email_body + '<table><tr><td width="10%" valign="top"><b><font size="2" color="#IF3400">Job: </b></font></td><td><font size="2">' 
							+ @JobName + '</font></td></tr>' 
							+ '<tr><td width="10%" valign="top"><b><font size="2" color="#IF3400">Start: </b></font></td><td><font size="2">' 
							+ @JobStartTimeLocal + '</font></td></tr>'
							+ '<tr><td width="10%" valign="top"><b><font size="2" color="#IF3400">Failure: </b></font></td><td><font size="2">' 
							+ @JobFailureTimeLocal + '</font></td></tr>'
							+ '<tr><td width="10%" valign="top"><b><font size="2" color="#IF3400">Step Name: </b></font></td><td><font size="2">' 
							+ @JobStepFailureName + '</font></td></tr>'
							+ '<tr><td width="10%" valign="top"><b><font size="2" color="#IF3400">Job Msg: </b></font></td><td><font size="2">' 
							+ @JobFailureMessage + '</font></td></tr>'
							+ '<tr><td width="10%" valign="top"><b><font size="2"color="#IF3400">Step Msg: </b></font></td><td><font size="2">' 
							+ @JobStepFailureMessage + '</font></td></tr>' + '</tr></table><br><br>'
							
-- Iterate to the Next Record
SET @Index = @Index + 1
;

END	

-- Send an email to an operator if any new errors are found.
IF EXISTS
(
SELECT	*
FROM	dbo.sql_server_agent_job_failure
WHERE	sql_server_agent_job_failure.has_email_been_sent_to_operator = 0
)
BEGIN

SELECT	@email_subject	= 'Failed Job Alert: ' + CAST(@job_failure_count AS Varchar(MAX)) 
							+ CASE WHEN @job_failure_count = 1 
								THEN ' Job Has Failed On ' 
								ELSE ' Jobs Have Failed On '
								END	  
							+ ISNULL(@@SERVERNAME, CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))) + ' - ' + FORMAT(GETDATE(), 'MM/dd/yyyy HH:mm');

SELECT	@email_body = @email_body + '</body></html>' 

EXEC msdb.dbo.sp_send_dbmail @profile_name = @profile_name
							, @recipients = @email_to_address
							, @subject = @email_subject
							, @body_format = 'html'
							, @body = @email_body;

UPDATE	sql_server_agent_job_failure
SET		has_email_been_sent_to_operator = 1
FROM	dbo.sql_server_agent_job_failure
WHERE	sql_server_agent_job_failure.has_email_been_sent_to_operator = 0;
END

DROP TABLE #job_step_failure;
DROP TABLE #job_failure;
END
