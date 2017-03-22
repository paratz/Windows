Param(
  [string]$ComputerName,
  [string]$ComputerNameListFile,
  [string]$CounterName,
  [string]$BeginDate,
  [string]$RunForXHours,
  [string]$SampleInterval,
  [string]$OutputFile,
  [string]$CounterFile
)

#Example Run for a single computer: .\Configure-PerfCounters.ps1 -ComputerName Server01



#The following command would configure a performance counter log to begin data collection on SERVER1 at 6:00am on December 25, 2008.  Data collection would occur every 30 seconds for four hours, and would use the performance counters specified in the exchperfcounters.txt file.  [The script is text and can be copied and pasted into a command-line window.]

logman -s %computername% create counter %computername%-perf -b 03/26/2012 11:00:00AM -rf 4:00:00 -si 00:00:15 -o C:\Perflogs\%computername%-perf.blg -cf C:\temp\exchperfcounters.txt

#The string breaks down as follows:
#•	Logman invokes the Performance Log Utility on the local system, while –s SERVER1 sets the target to SERVER1.  If logman were invoked from SERVER1 itself (from within a Remote Desktop session, for example), the –s parameter would be unnecessary.
#•	The create counter SERVER1-perf specifies that we wish to create a performance counter log (as opposed to a trace log or an alert) named SERVER1-perf.  Although administrators can use any string for the name, anything with spaces requires the use of quotation marks (“”) around the string.
#•	The –b 12/25/2008 6:00:00AM specifies the beginning date and time.  The date format should be MM/DD/YYYY while the time should include hours, minutes, and seconds, as well as the AM/PM indicator.  This time is local to the target server.
#•	The –rf 4:00:00 indicates the length of time to collect in HH:MM:SS format.
#•	The –si 00:00:30 indicates the sample interval, again in HH:MM:SS format.
#•	The –o C:\Perflogs\SERVER1-perf.blg indicates the full output filename, including path.  If the path or filename includes spaces, you must enclose it with quotation marks.
#•	The –cf C:\exchperfcounters.txt indicates the path to the file containing the list of performance counters.  The five attached files include the common counter sets for the main roles and combinations – CAS, HT, MBX, UM, and CAS+HT.  Additional counters can be added to any of the files – the format is simply \object\countername. 