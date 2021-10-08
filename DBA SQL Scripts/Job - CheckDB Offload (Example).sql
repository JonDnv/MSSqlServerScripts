USE [msdb]
GO

/****** Object:  Job [CheckDB - DB1]    Script Date: 10/8/2021 11:04:06 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 10/8/2021 11:04:06 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CheckDB - DB1', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Job performs a test restore & CheckDB against all databases on 000-SRV-DB1', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [aspnetdb]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'aspnetdb', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''aspnetdb''
, @RestoreDatabaseName = ''DB1_aspnetdb''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\aspnetdb\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\aspnetdb\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\aspnetdb\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [ASPState]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'ASPState', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''ASPState''
, @RestoreDatabaseName = ''DB1_ASPState''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\ASPState\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\ASPState\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\ASPState\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [distribution]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'distribution', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''distribution''
, @RestoreDatabaseName = ''DB1_distribution''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\distribution\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\distribution\DIFF\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Integration]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Integration', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''Integration''
, @RestoreDatabaseName = ''DB1_Integration''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\Integration\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\Integration\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\Integration\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [LivingNaturally]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'LivingNaturally', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''LivingNaturally''
, @RestoreDatabaseName = ''DB1_LivingNaturally''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\LivingNaturally\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\LivingNaturally\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\LivingNaturally\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [master]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'master', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''master''
, @RestoreDatabaseName = ''DB1_master''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\master\FULL\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @TestRestore = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [MCM]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'MCM', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''MCM''
, @RestoreDatabaseName = ''DB1_MCM''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\MCM\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\MCM\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\MCM\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [MobiControlDB]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'MobiControlDB', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''MobiControlDB''
, @RestoreDatabaseName = ''DB1_MobiControlDB''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\MobiControlDB\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\MobiControlDB\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\MobiControlDB\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [model]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'model', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''model''
, @RestoreDatabaseName = ''DB1_model''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\model\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\model\DIFF\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [msdb]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'msdb', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''msdb''
, @RestoreDatabaseName = ''DB1_msdb''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\msdb\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\msdb\DIFF\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [PHARMHOUSE]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'PHARMHOUSE', 
		@step_id=11, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''PHARMHOUSE''
, @RestoreDatabaseName = ''DB1_PHARMHOUSE''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\PHARMHOUSE\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\PHARMHOUSE\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\PHARMHOUSE\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [RockySoft_Ecom]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'RockySoft_Ecom', 
		@step_id=12, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''RockySoft_Ecom''
, @RestoreDatabaseName = ''DB1_RockySoft_Ecom''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\RockySoft_Ecom\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\RockySoft_Ecom\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\RockySoft_Ecom\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [SSISDB]    Script Date: 10/8/2021 11:04:06 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'SSISDB', 
		@step_id=13, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_DatabaseRestore
@Database = ''SSISDB''
, @RestoreDatabaseName = ''DB1_SSISDB''
, @BackupPathFull = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\SSISDB\FULL\''
, @BackupPathDiff = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\SSISDB\DIFF\''
, @BackupPathLog = ''\\254-idpa-dd1.pharmaca.com\DB1-Backups\000-SRV-DB1\SSISDB\LOG\''
, @MoveFiles = 1
, @MoveDataDrive = ''M:\MSSQL.MSSQLSERVER.DATA\''
, @MoveLogDrive = ''L:\MSSQL.MSSQLSERVER.LOG\''
, @RunCheckDB = 1
, @ForceSimpleRecovery = 1
, @RunRecovery = 1
, @TestRestore = 1
, @RestoreDiff = 1
;', 
		@database_name=N'master', 
		@flags=20
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'CheckDB - MON / WED / FRI', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=42, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20190602, 
		@active_end_date=99991231, 
		@active_start_time=80000, 
		@active_end_time=235959, 
		@schedule_uid=N'cffc8496-7373-4ade-b638-94ee165e9553'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


