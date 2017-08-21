#Para correrlo localmente en cada server:

logman -s %computername% create counter %computername%-perf -f bincirc -max 300 -si 00:00:15 -o C:\Perflogs\%computername%-perf.blg -cf C:\temp\WindowsPerformance.txt

logman -s %computername% start %computername%-perf

schtasks /create /tn %computername%-perf /sc onstart /tr "logman start %computername%-perf" /ru system /S %computername%

#Para correrlo remotamente:

logman -s SERVER1 create counter SERVER1-perf -f bincirc -max 300 -si 00:00:15 -o C:\Perflogs\SERVER1-perf.blg -cf C:\temp\WindowsPerformance.txt

logman -s SERVER1 start SERVER1-perf

schtasks /create /tn SERVER1-perf /sc onstart /tr "logman start SERVER1-perf" /ru system /S SERVER1
