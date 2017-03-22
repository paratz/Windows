#How I can find the name of the Enterprise Root Certificate Autority server?
 
#Option 1:
 
 
#1. Logon by using domain administrator to computer that connect to the 
# 
#       domain.
# 
#2. Go to "Start" -> "Run" -> Write "cmd" and press on "Enter" button.
# 
#3. Write "certutil.exe" command and press on "Enter" button. 

Invoke-Command "certutil.exe"

#https://support.microsoft.com/en-us/help/555529 