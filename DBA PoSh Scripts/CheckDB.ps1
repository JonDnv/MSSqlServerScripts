Workflow Check-DBIntegrity
{
    Parallel 
    {
    Invoke-Sqlcmd2 -ServerInstance 000-SRV-DB1 -ConnectionTimeout 0 -QueryTimeout 43200 -Database master -ErrorAction Stop -Query "EXEC dbo.DBA_CheckDB"
    Invoke-Sqlcmd2 -ServerInstance 000-SRV-DB1 -ConnectionTimeout 0 -QueryTimeout 43200 -Database master -ErrorAction Stop -Query "EXEC dbo.DBA_CheckDB"
    }
}
Clear-Host
Check-DBIntegrity