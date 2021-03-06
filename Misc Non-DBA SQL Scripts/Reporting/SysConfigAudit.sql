USE [master]
GO
/****** Object:  StoredProcedure [dbo].[SysConfigAudit]    Script Date: 10/8/2021 9:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =================================================================
-- Author:		Jon Godwin
-- Create date: 2018-08-06
-- Description:	Tracks Configuration Settings to Table for Auditing
-- =================================================================
CREATE PROCEDURE [dbo].[SysConfigAudit] 
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO	[000-WINSRV-RPT].[ITReporting].[dbo].[SysConfigHistory]
(
ServerName
, CaptureDate
, ConfigID
, ConfigName
, ConfigValue
, ConfigMin
, ConfigMax
, ConfigValueInUse
, ConfigDesc
, IsDynamics
, IsAdvanced
, ConfigSum
)
(
SELECT	@@SERVERNAME
		, GETDATE()
		, C.configuration_id
		, C.name
		, C.value
		, C.minimum
		, C.maximum
		, C.value_in_use
		, C.description
		, C.is_dynamic
		, C.is_advanced
		, CAST(C.value AS BigInt) + CAST(C.minimum AS BigInt) + CAST(C.maximum AS BigInt) + CAST(C.value_in_use AS BigInt)
			+ CAST(C.is_dynamic AS BigInt) + CAST(C.is_advanced AS BigInt)
FROM	sys.configurations C
)
;

INSERT INTO [000-WINSRV-RPT].[ITReporting].[dbo].[SysConfigChecksum]
(
Server
, QueryDate
, SysConfigSum
)
(
SELECT	@@SERVERNAME
		, MAX(SCH.CaptureDate)
		, SUM(ConfigSum)
FROM	[000-WINSRV-RPT].[ITReporting].[dbo].[SysConfigHistory] SCH
WHERE	CONVERT(Date,SCH.CaptureDate) = (SELECT CONVERT(Date,MAX(SCH2.CaptureDate)) FROM [000-WINSRV-RPT].[ITReporting].[dbo].[SysConfigHistory] SCH2)
)

END
