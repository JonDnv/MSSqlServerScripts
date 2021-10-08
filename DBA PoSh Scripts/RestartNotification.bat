@echo off
title SQL Service Failure Email	
powershell.exe "Send-MailMessage -SmtpServer 'smtp.pharmaca.com' -From 'DB1 Database Server <db1server@pharmaca.com>' -To 'dbaalerts@pharmaca.com' -Subject '000-SRV-DB1 Restart' -Body 'The Database Server, 000-SRV-DB1, has restarted. Check that the server & database instance are functioning correctly as soon as possible.'"