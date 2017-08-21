Param(
  [string] $serverlist,
  [string] $reporttextfile
  )

out-file -filepath $reporttextfile -append -InputObject ("Reporte Usuarios Locales " + (Get-Date))

foreach ($server in Get-Content $serverlist)
{
  "Reportando Servidor:" + $server | out-file -filepath $reporttextfile -append
  Get-WmiObject -computername $Server -Class Win32_UserAccount -Filter  "LocalAccount='True'" | Where-Object {$_.PasswordExpires -eq "True"} | Select-Object Name, Status, Disabled, Lockout, PasswordRequired, PasswordChangeable, SID | out-file -filepath $reporttextfile -append
  }