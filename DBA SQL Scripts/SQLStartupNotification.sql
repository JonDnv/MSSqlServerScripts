USE [master]
GO
/****** Object:  StoredProcedure [dbo].[SQLStartupNotification]    Script Date: 10/8/2021 9:56:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-09-23
-- Description:	Notifies DBA That the Instance
--				Has Been Restarted & Needs to be
--				checked. 
-- =============================================
CREATE PROCEDURE [dbo].[SQLStartupNotification] 
AS
BEGIN
SET NOCOUNT ON;

DECLARE @p_body AS NVarchar(MAX), @p_subject AS NVarchar(MAX)
DECLARE @p_recipients AS NVarchar(MAX), @p_profile_name AS NVarchar(MAX)

SET @p_profile_name = N'DB1 SQL Agent'
SET @p_recipients = N'dbaalerts@pharmaca.com'
SET @p_subject = 'SQL Instance Restart: ' + ISNULL(@@SERVERNAME, CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX)));
SET @p_body = 'The SQL Server Instance has restarted on ' + ISNULL(@@SERVERNAME, CAST(SERVERPROPERTY('ServerName') AS Varchar(MAX))) + '. All Databases have been recovered. Check the status of the SQL Server instance as soon as possible.'

EXEC msdb.dbo.sp_send_dbmail
  @profile_name = @p_profile_name,
  @recipients = @p_recipients,
  @body = @p_body,
  @subject = @p_subject

END
