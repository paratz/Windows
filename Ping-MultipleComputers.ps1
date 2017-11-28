Param(
  [string]$ServerListFile
  
)

#Este script sirve para hacer ping a múltiples computadoras.
#
#Utilización:
#
# .\Ping-MultipleComputers.ps1 -ServerListFile "C:\Temp\Computers.txt" >> Output.txt

$ServerName = Get-Content $ServerListFile
  
foreach ($Server in $ServerName) {  
  
        if (test-Connection -ComputerName $Server -Count 2 -Quiet ) {   
          
            "$Server OK"  
          
                    } else  
                      
                    {"$Server Failed"  
              
                    }      
          
} 
