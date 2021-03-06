USE [master]
GO

/****** Object:  Table [dbo].[CommandLog]    Script Date: 10/8/2021 10:20:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CommandLog](
	[ID] [Int] IDENTITY(1,1) NOT NULL,
	[DatabaseName] [sysname] NULL,
	[SchemaName] [sysname] NULL,
	[ObjectName] [sysname] NULL,
	[ObjectType] [Char](2) NULL,
	[IndexName] [sysname] NULL,
	[IndexType] [TinyInt] NULL,
	[StatisticsName] [sysname] NULL,
	[PartitionNumber] [Int] NULL,
	[ExtendedInfo] [Xml] NULL,
	[Command] [NVarchar](MAX) NOT NULL,
	[CommandType] [NVarchar](60) NOT NULL,
	[StartTime] [DateTime] NOT NULL,
	[EndTime] [DateTime] NULL,
	[ErrorNumber] [Int] NULL,
	[ErrorMessage] [NVarchar](MAX) NULL,
 CONSTRAINT [PK_CommandLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


USE [master]
GO
/****** Object:  StoredProcedure [dbo].[MaintenancePlanErrors]    Script Date: 10/8/2021 9:55:46 AM ******/
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
CREATE PROCEDURE [dbo].[MaintenancePlanErrors]	 
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
DECLARE @ReportRange datetime = DATEADD(HOUR,-25,GETDATE())
;

-- Declare Maintenance Plan Variables
DECLARE @CommandID Varchar(MAX)
DECLARE @DatabaseName Varchar(MAX)
DECLARE @CommandType Varchar(MAX)
DECLARE @Command Varchar(MAX)
DECLARE @StartTime Varchar(MAX)
DECLARE @ErrorNumber Varchar(MAX)
DECLARE	@IssueIndex Int 
DECLARE	@MaxIndex Int 
;

-- Declare Maintenance Plan Loop Table
DECLARE	@MaintIssuesLoop Table
(
ID Int IDENTITY (1,1)
, CommandID Int NOT NULL
, DatabaseName NVarchar(128) NULL
, CommandType NVarchar(60) NOT NULL
, Command NVarchar(MAX) NOT NULL
, StartTime DateTime NOT NULL
, ErrorNumber Int NULL
, ErrorMessage NVarchar(MAX) NULL
)
;

-- Populate Loop Table
INSERT INTO @MaintIssuesLoop
	(
	CommandID
	, DatabaseName
	, CommandType
	, Command
	, StartTime
	, ErrorNumber
	, ErrorMessage
	)
SELECT	CL.ID
		, CL.DatabaseName
		, CL.CommandType
		, CL.Command
		, CL.StartTime
		, CL.ErrorNumber
		, CL.ErrorMessage
FROM	master.dbo.CommandLog CL
WHERE	CL.StartTime > @ReportRange
		AND CL.ErrorNumber <> 0
;

-- Set @Count
SELECT	@Count = ISNULL(COUNT(*),0)
FROM	@MaintIssuesLoop MIL
;

-- Set @EmailSubject
SELECT @EmailSubject = 'Maintenance Task Issues | ' + CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX)) + ' | ' + FORMAT(DATEADD(DAY,-1,GETDATE()), 'MM/dd/yyyy')
;

-- Set @EmailBody Start
SELECT	@EmailBody = '<html><body><table style="width:100%" bgcolor="ad6400"><tr><td align="center" valign="middle" height="15">'
						+ '<font color="ffffff" size="4"><b>Maintenance Task Issues</b></font></td></tr></table><br>'
;

-- Set the Max Index for Job Loop Table
SELECT	@MaxIndex = MAX(MIL.ID)
		, @IssueIndex = 1
FROM	@MaintIssuesLoop MIL
;

-- Set @EmailBody Header
IF ISNULL(@MaxIndex,0) < 1 SET @EmailBody = @EmailBody
ELSE SET @EmailBody = @EmailBody + '<font color="#002793"><b>'
						+ CONVERT(Varchar(MAX), @Count) 
						+ CASE
							WHEN @Count = 1 THEN ' Maintenance Task Issue Found on '
							ELSE ' Maintenance Task Issues Found on '
							END
						+ CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))
						+ ':</font></b><br>'
;

-- Check The Data
IF ISNULL(@MaxIndex,0) < 1
BEGIN
	RETURN;
END	

-- Iterate Through Job Loop Table
WHILE @IssueIndex <= @MaxIndex
BEGIN	

SELECT	@CommandID = CAST(MIL.CommandID AS Varchar(MAX))
		, @DatabaseName = CAST(MIL.DatabaseName AS Varchar(MAX))
		, @CommandType = CAST(MIL.CommandType AS Varchar(MAX))
		, @Command = CAST(MIL.Command AS Varchar(MAX))
		, @StartTime = CAST(MIL.StartTime AS Varchar(MAX))
		, @ErrorNumber = CAST(MIL.ErrorNumber AS Varchar(MAX))
FROM	@MaintIssuesLoop MIL
WHERE	MIL.ID = @IssueIndex
;

-- Format Job Portion of Email
SELECT @EmailBody = @EmailBody + '<table><tr><td valign="top"><b><font size="2" color="#IF3400">Command ID: </b></font></td><td><font size="2">' 
							+ @CommandID + '</font></td></tr>' 
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Database Name: </b></font></td><td><font size="2">' 
							+ @DatabaseName + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Command Type: </b></font></td><td><font size="2">' 
							+ @CommandType + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Command: </b></font></td><td><font size="2">' 
							+ @Command + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Start Time: </b></font></td><td><font size="2">' 
							+ @StartTime + '</font></td></tr>'
							+ '<tr><td valign="top"><b><font size="2" color="#IF3400">Error Number: </b></font></td><td><font size="2">' 
							+ @ErrorNumber + '</font></td></tr>' + '</tr></table><br><br>'


--  Iterate to the Next Record
SET @IssueIndex = @IssueIndex + 1
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
