﻿Get-WinEvent -logname Microsoft-Windows-Backup | Select-Object TimeCreated,Id,LevelDisplayName,Message,MachineName,UserId | Export-Csv -Path C:\temp\SERVER01backuplog.csv -NoTypeInformation 