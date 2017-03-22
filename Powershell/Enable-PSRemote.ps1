Enable-PSRemoting –force

winrm quickconfig

#server auth certificate needs to be installed on the vm

winrm quickconfig -transport:https

#When you are working with computers in workgroups or homegroups, 
#you must either use HTTPS as the transport or add the remote machine to the TrustedHosts configuration settings.
# If you cannot connect to a remote host, verify that the service on the remote host is running and is accepting 
#requests by running the following command on the remote host: 

set-item wsman:\localhost\Client\TrustedHosts -value *

#This command analyzes and configures the WinRM service. 

#To use Windows PowerShell remoting features, you must start Windows PowerShell as an administrator by right-clicking the Windows PowerShell shortcut and selecting Run As Administrator. When starting PowerShell from another program, such as the command prompt (cmd.exe), you must start that program as an administrator. 

# Add a new firewall rule, default port is 5986

port=5986
netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=$port

