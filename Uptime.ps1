$serverlist = "C:\temp\sl.txt"
$reporttextfile = "C:\temp\uptimereport.txt"
out-file -filepath $reporttextfile -append -InputObject ("Uptime Report Run " + (Get-Date))
foreach ($server in Get-Content $serverlist)
{
 $ping = gwmi win32_pingstatus -f "Address = '$server'"
 if($ping.statuscode -eq 0)
 {
    $wmi = Get-WmiObject -ComputerName $server -Query "SELECT LastBootUpTime FROM Win32_OperatingSystem"    
    $now = Get-Date    
    $boottime = $wmi.ConvertToDateTime($wmi.LastBootUpTime)
    out-file -filepath $reporttextfile -append -InputObject ("Uptime for " + $server + ": " + ($now - $boottime))
 }
 else
 {
    out-file -filepath $reporttextfile -append -InputObject ("Uptime for " + $server + ": Host offline")
 }
}