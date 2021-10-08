Try
{
    Export-DbaSpConfigure -SqlInstance 000-SRV-DB1 -FilePath \\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\DB1_SPCONFIG.SQL -EnableException -ErrorAction SilentlyContinue
    Export-DbaLogin -SqlInstance 000-SRV-DB1 -EnableException -FilePath \\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\DB1_LOGINS.SQL -ErrorAction Stop
    Export-DbaUser -SqlInstance 000-SRV-DB1 -EnableException -FilePath \\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\DB1_DBUSERS.SQL -ErrorAction Stop
    Get-DbaAgentJob -SqlInstance 000-SRV-DB1 -EnableException | Export-DbaScript -FilePath \\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\DB1_JOBS.SQL -ErrorAction Stop
    Get-DbaDbStoredProcedure -SqlInstance 000-SRV-DB1 -ExcludeSystemSp -EnableException | Export-DbaScript -FilePath \\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\DB1_SPROCS.SQL -ErrorAction Stop
    Get-DbaLinkedServer -SqlInstance 000-SRV-DB1 -EnableException | Export-DbaScript -FilePath \\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\DB1_LINKEDSERVERS.SQL -ErrorAction Stop
    Copy-Item -Path 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Binn\mssqlsystemresource.mdf' -Destination '\\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\ResourceDB\mssqlsystemresource.mdf' -ErrorAction Stop
    Copy-Item -Path 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Binn\mssqlsystemresource.ldf' -Destination '\\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\ResourceDB\mssqlsystemresource.ldf' -ErrorAction Stop
    Compress-Archive -LiteralPath '\\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles\' -DestinationPath ('\\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles ' + (Get-Date -Format yyyyMMdd) + '.zip') -CompressionLevel Optimal -ErrorAction Stop
    Get-ChildItem -Path \\254-idpa-dd1.pharmaca.com\DB1-Backups\BackupFiles -Include *.* -File -Recurse | foreach {$_.Delete()} -ErrorAction Stop
    Get-ChildItem -Path '\\254-idpa-dd1.pharmaca.com\DB1-Backups' -Include BackupFiles*.zip -File | Where-Object {$_.CreationTime -lt (Get-Date).AddDays(-90)} | Remove-Item -ErrorAction Stop
    Exit
} 
Catch
{
    Send-MailMessage -SmtpServer smtp.pharmaca.com -From "DB1 SQL Agent <db1agent@pharmaca.com>" -Subject "000-SRV-DB1 SQL File Backup Failed" -Body "The SQL file backup scheduled task on 000-SRV-DB1 failed to complete. Verify functionality and rerun." -To dbanotifications@pharmaca.com
    Exit
}