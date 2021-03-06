USE [master]
GO
/****** Object:  StoredProcedure [dbo].[SQLAgentStartupNotification]    Script Date: 10/8/2021 9:56:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-09-23
-- Description:	Stored Procedure used in job that
--				notifies DBA that the SQL Agent
--				started / restarted.
-- =============================================
ALTER PROCEDURE [dbo].[SQLAgentStartupNotification] 
AS
BEGIN
SET NOCOUNT ON;

DECLARE @p_body AS NVarchar(MAX), @p_subject AS NVarchar(MAX)
DECLARE @p_recipients AS NVarchar(MAX), @p_profile_name AS NVarchar(MAX)

SET @p_profile_name = N'DB1 SQL Agent'
SET @p_recipients = N'dbaalerts@pharmaca.com'
SET @p_subject = 'SQL Agent Restart: ' + ISNULL(@@SERVERNAME, CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX)));
SET @p_body = 'The SQL Server Agent has restarted on ' + ISNULL(@@SERVERNAME, CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))) + '. Check the status of the SQL Server instance as soon as possible.'

EXEC msdb.dbo.sp_send_dbmail
  @profile_name = @p_profile_name,
  @recipients = @p_recipients,
  @body = @p_body,
  @subject = @p_subject


END
