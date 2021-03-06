USE [master]
GO
/****** Object:  StoredProcedure [dbo].[TriggerAudit]    Script Date: 10/8/2021 9:56:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jon Godwin
-- Create date: 2018-11-14
-- Description:	Captures Trigger Information in 
--				the Reporting Server in the 
--				ITReporting Database 
-- =============================================
CREATE PROCEDURE [dbo].[TriggerAudit]
AS
BEGIN
SET NOCOUNT ON;

EXEC master.dbo.sp_foreachdb
'
USE ?
INSERT INTO [000-WINSRV-RPT].[ITReporting].[dbo].[InstanceTriggers]	
(
ServerName
, DatabaseName
, TableName
, TriggerName
, TriggerOwner
, IsUpdate
, IsDelete
, IsInsert
, IsAfter
, IsInsteadOf
, Status
, QueryDate
)
(
SELECT	@@SERVERNAME ServerName
		, DB_NAME() DatabaseName
		, OBJECT_NAME(parent_object_id)	TableName
		, name TriggerName
		, USER_NAME(schema_id) TriggerOwner
		, OBJECTPROPERTY(object_id, ''ExecIsUpdateTrigger'') IsUpdate
		, OBJECTPROPERTY(object_id, ''ExecIsDeleteTrigger'') IsDelete
		, OBJECTPROPERTY(object_id, ''ExecIsInsertTrigger'') IsInsert
		, OBJECTPROPERTY(object_id, ''ExecIsAfterTrigger'') IsAfter
		, OBJECTPROPERTY(object_id, ''ExecIsInsteadOfTrigger'') IsInsteadOf
		, CASE OBJECTPROPERTY(object_id, ''ExecIsTriggerDisabled'') 
			WHEN 1 THEN ''Disabled''
			ELSE ''Enabled''
			END AS Status
		, GETDATE()
FROM	sys.objects
WHERE	type = ''TR''
)
'

END
