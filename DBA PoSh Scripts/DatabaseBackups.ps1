Workflow Perform-DBBackups
{
    Parallel 
    {
    Invoke-Sqlcmd2 -ServerInstance 000-SRV-DB1 -ConnectionTimeout 0 -QueryTimeout 43200 -Database master -ErrorAction Stop -Query "EXEC dbo.DBA_NightlyBackups"
    Invoke-Sqlcmd2 -ServerInstance 000-SRV-DB1 -ConnectionTimeout 0 -QueryTimeout 43200 -Database master -ErrorAction Stop -Query "EXEC dbo.DBA_NightlyBackups"
    }
}
Clear-Host
Perform-DBBackups