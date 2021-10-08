[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Try
{
    Update-Module -Name 'dbachecks','dbareports','dbatools', 'PSWindowsUpdate', 'ReportingServicesTools', 'SqlServer', 'SQLServerJobsModule','SQLServerUpdatesModule', 'sqlserverdsc', '7zip4powershell', 'get-activeuser', 'start-multithread', 'zWindowsUpdate', 'Invoke-Sqlcmd2' -Force -ErrorAction Stop
    Send-MailMessage -SmtpServer smtp.pharmaca.com -From "DB1 Database Server <db1server@pharmaca.com>" -Subject "000-SRV-DB1 Powershell Modules Updated Successfully" -Body "The powershell module update scheduled task on 000-SRV-DB1 has completed successfully." -To developers@pharmaca.com
    Exit
} 
Catch
{
    Send-MailMessage -SmtpServer smtp.pharmaca.com -From "DB1 Database Server <db1server@pharmaca.com>" -Subject "000-SRV-DB1 Powershell Modules Failed to Update" -Body "The powershell module update scheduled task on 000-SRV-DB1 failed to complete. Update the modules manually." -To developers@pharmaca.com 
    Exit
}