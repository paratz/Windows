Param(
  [string]$ComputerName
)

#Example Run: .\Connect-PSRemote.ps1 -ComputerName srvdc1.contoso.com

$cred = Get-Credential
$pso = New-PSSessionOption -SkipRevocationCheck
Enter-PSSession -ComputerName $ComputerName -Credential $cred -UseSSL -SessionOption $pso
