$server = '000-SRV-DB1'
$shareStatus = Test-Path -Path \\254-idpa-dd1.pharmaca.com\DB1-Backups
$lastStatus = Invoke-DbaQuery -SqlInstance $server -Database master -Query "Select TOP(1) ShareStatus FROM dbo.ShareStatus ORDER BY TimeStamp DESC" -As SingleValue

if (($lastStatus -eq "False") -and ($shareStatus -eq $true)) {
    Set-DbaAgentJob -SqlInstance $server -Job 'DBA - Emergency Backups','DBA - Generate Restore Scripts','DBA - Log Backups', 'DBA - Nightly File Maintenance', 'DBA - SQL Agent Job Documentation' -Enabled
    Invoke-DbaQuery -SqlInstance $server -Database master -Query "INSERT INTO dbo.ShareStatus (ShareStatus) VALUES ('$shareStatus')"
    Send-MailMessage -SmtpServer smtp.pharmaca.com -From 'DB1 SQL Agent <db1agent@pharmaca.com>' -To dbaalerts@pharmaca.com -Subject 'DB1 Share Back Online' -Body 'The DB1-Backups share on the IDPA is back available. The following jobs have been reenabled:<br/><br/>DBA - Azure Copy<br/>DBA - Emergency Backups<br/>DBA - Generate Restore Scripts<br/>DBA - Log Backups<br/>DBA - Nightly File Maintenance<br/>DBA - SQL Agent Job Documentation<br/><br/>Confirm the status of these jobs as soon as possible.<br/><br/>Full backups of all databases have been started. Confirm these backups are underway.' -BodyAsHtml
    Invoke-DbaQuery -SqlInstance $server -Database master -Query "DELETE dbo.ShareStatus WHERE TimeStamp < DATEADD(WEEK, -1, GETDATE())"
    Invoke-DbaQuery -SqlInstance $server -Database master -Query "EXEC dbo.DBA_FullBackups"
    Exit
}
elseif (($lastStatus -eq "True") -and ($shareStatus -eq $false)) {
    Set-DbaAgentJob -SqlInstance $server -Job 'DBA - Emergency Backups','DBA - Generate Restore Scripts','DBA - Log Backups', 'DBA - Nightly File Maintenance', 'DBA - SQL Agent Job Documentation' -Disabled
    Invoke-DbaQuery -SqlInstance $server -Database master -Query "INSERT INTO dbo.ShareStatus (ShareStatus) VALUES ('$shareStatus')"
    Invoke-DbaQuery -SqlInstance $server -Database master -Query "DELETE dbo.ShareStatus WHERE TimeStamp < DATEADD(WEEK, -1, GETDATE())"
    Send-MailMessage -SmtpServer smtp.pharmaca.com -From 'DB1 SQL Agent <db1agent@pharmaca.com>' -To dbaalerts@pharmaca.com -Subject 'DB1 Share Offline' -Body 'The DB1-Backups share on the IDPA is offline.<br/><br/> The following jobs have been disabled:<br/><br/>DBA - Azure Copy<br/>DBA - Emergency Backups<br/>DBA - Generate Restore Scripts<br/>DBA - Log Backups<br/>DBA - Nightly File Maintenance<br/>DBA - SQL Agent Job Documentation<br/><br/>Rectify this issue as soon as possible.' -BodyAsHtml
    Exit
}
else {
    Invoke-DbaQuery -SqlInstance $server -Database master -Query "INSERT INTO dbo.ShareStatus (ShareStatus) VALUES ('True')"
    Invoke-DbaQuery -SqlInstance $server -Database master -Query "DELETE dbo.ShareStatus WHERE TimeStamp < DATEADD(WEEK, -1, GETDATE())"
    Exit
}