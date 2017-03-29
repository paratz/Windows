# List network interfaces

netsh interface ipv4 show interfaces 

#name="x" where x is the interface ID 

netsh interface ipv4 set address name="1" source=static address=161.131.192.228 mask=255.255.255.0 gateway=161.131.192.225

netsh interface ipv4 add dnsserver name="1" address=161.131.192.225 index=1

#Delete all DNS servers

netsh int ipv4 delete dns servers name="1" all

#rename the server

netdom renamecomputer <ComputerName> /NewName:<NewComputerName>

#inmediate restart
shutdown /r /t 0 

#join to domain

netdom join <ComputerName> /domain:<DomainName> /userd:<UserName> /passwordd:*

#enable RDP on the server

cscript %windir%\system32\scregedit.wsf /ar 0 

#enable icmp on the server
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

#disable the entire windows firewall

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False.
