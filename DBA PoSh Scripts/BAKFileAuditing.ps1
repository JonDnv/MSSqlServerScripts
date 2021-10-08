Get-WmiObject Win32_LogicalDisk -Filter "DriveType = 3" |
Select-Object DeviceID |
ForEach-Object {Get-Childitem ($_.DeviceID + "\") -Include *.bak -Recurse -File -ErrorAction SilentlyContinue | Select @{Name="Server";Expression={$env:COMPUTERNAME}}, @{Name="QueryDate";Expression={Get-Date}}, PSDrive, Directory, Name, FullName | ConvertTo-DbaDataTable | Write-DbaDataTable -SqlInstance 000-winsrv-rpt -Database ITReporting -Table BAKFiles -AutoCreateTable}
