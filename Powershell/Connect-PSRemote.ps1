Param(
  [string]$ComputerName
)

#Example Run: .\Connect-PSRemote.ps1 -ComputerName srvdc1.contoso.com

$cred = Get-Credential
$pso = New-PSSessionOption -SkipRevocationCheck
<<<<<<< HEAD
Enter-PSSession -ComputerName srvdc1.contoso.com -Credential $cred -UseSSL -SessionOption $pso

#more info http://www.visualstudiogeeks.com/devops/how-to-configure-winrm-for-https-manually
=======
Enter-PSSession -ComputerName $ComputerName -Credential $cred -UseSSL -SessionOption $pso
>>>>>>> origin/master
