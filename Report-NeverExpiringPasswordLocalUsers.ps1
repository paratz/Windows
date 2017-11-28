
Param( 
  [string] $serverlist 
#  [string] $reporttextfile 
  ) 

#out-file -filepath $reporttextfile -append -InputObject ("Reporte Usuarios Locales " + (Get-Date)) 

foreach ($server in Get-Content $serverlist) 
{ 

$filename = $server + ".csv" 
#  "Reportando Servidor:" + $server | out-file -filepath $reporttextfile -append 
  Get-WmiObject -computername $Server -Class Win32_UserAccount -Filter  "LocalAccount='True'"  | Where-Object {$_.PasswordExpires -eq $False} | Select-Object Name, Status, Description, Disabled, Lockout, PasswordRequired, PasswordChangeable, PasswordExpires, SID | Export-Csv -Path $filename -NoTypeInformation -Encoding Unicode 
# 

  } 

