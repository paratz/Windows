$name = "Win32_perfformatteddata" 
$WMIClasses = Get-WmiObject -List | Where-Object {$_.name -Match $name}

foreach($class in $WMIClasses)
{
$class.Name
}

#Examples of some performance object wmi objects:
#$ntds = Get-WmiObject -Query "Select * from Win32_PerfFormattedData_NTDS_NTDS"
#$process = Get-WmiObject -Query "Select * from Win32_PerfFormattedData_PerfProc_Process"
#$server = Get-WmiObject -Query "Select * from Win32_PerfFormattedData_PerfNet_Server"
#$auths = Get-WmiObject -Query "Select * from Win32_PerfFormattedData_Lsa_SecuritySystemWideStatistics"
