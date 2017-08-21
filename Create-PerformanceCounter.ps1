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

#Parameters

$ComputerName = paratz-t460s
#$ComputerNameListFile = 
$CounterName = paratz-t460s-perf
$BeginDate = "04/21/2017 10:00:00AM"
$SampleInterval = "00:00:15"
$OutputFile = "C:\Perflogs\paratz-t460s-perf.blg"
$CounterFile = "C:\temp\exchperfcounters.txt"

if ($BeginDate -eq $Null) {

#Si no se especifica una fecha de inicio del contador, se configura para dentro de 15 minutos

    $ts = New-TimeSpan -Days 0 -Hours 0 -Minutes 15
    $BeginDate = (get-date) + $ts

}

if ($RunForXHours -eq $Null) {

#Si no se especifica la cantidad de horas a correr, se ejecuta por 1 hora

$RunForXHours = 1

}

if ($SampleInterval -eq $Null) {

#Si no se especifica el intervalo de muestreo, se configura cada 15 segundos

$SampleInterval = "00:00:15"

}

If ($ComputerName -eq $Null -and $ComputerNameListFile -ne $Null) {
# Se eligió un archivo de nombres en lugar de un server

}


If ($ComputerName -ne $Null -and $ComputerNameListFile -eq $Null) {
 # Se definió el nombre de un equipo en lugar de un archivo de nombres


 }

#Example Run for a single computer: .\Configure-PerfCounters.ps1 -ComputerName Server01

logman -s $ComputerName create counter "$ComputerName-perf" -b $BeginDate -rf $RunForXHours -si $SampleInterval -o $OutputFile -cf $CounterFile

#The following command would configure a performance counter log to begin data collection on SERVER1 at 6:00am on December 25, 2008.  Data collection would occur every 30 seconds for four hours, and would use the performance counters specified in the exchperfcounters.txt file.  [The script is text and can be copied and pasted into a command-line window.]

#logman -s %computername% create counter %computername%-perf -b 03/26/2012 11:00:00AM -rf 4:00:00 -si 00:00:15 -o C:\Perflogs\%computername%-perf.blg -cf C:\temp\exchperfcounters.txt

#The string breaks down as follows:
#•	Logman invokes the Performance Log Utility on the local system, while –s SERVER1 sets the target to SERVER1.  If logman were invoked from SERVER1 itself (from within a Remote Desktop session, for example), the –s parameter would be unnecessary.
#•	The create counter SERVER1-perf specifies that we wish to create a performance counter log (as opposed to a trace log or an alert) named SERVER1-perf.  Although administrators can use any string for the name, anything with spaces requires the use of quotation marks (“”) around the string.
#•	The –b 12/25/2008 6:00:00AM specifies the beginning date and time.  The date format should be MM/DD/YYYY while the time should include hours, minutes, and seconds, as well as the AM/PM indicator.  This time is local to the target server.
#•	The –rf 4:00:00 indicates the length of time to collect in HH:MM:SS format.
#•	The –si 00:00:30 indicates the sample interval, again in HH:MM:SS format.
#•	The –o C:\Perflogs\SERVER1-perf.blg indicates the full output filename, including path.  If the path or filename includes spaces, you must enclose it with quotation marks.
#•	The –cf C:\exchperfcounters.txt indicates the path to the file containing the list of performance counters.  The five attached files include the common counter sets for the main roles and combinations – CAS, HT, MBX, UM, and CAS+HT.  Additional counters can be added to any of the files – the format is simply \object\countername. 

$Ex2007HubCASCounter = '"\.NET CLR Exceptions(*)\# of Exceps Thrown / sec" "\.NET CLR Memory(*)\# Bytes in all Heaps" "\.NET CLR Memory(*)\% Time in GC" "\ASP.NET Applications(*)\Requests In Application Queue" "\ASP.NET Applications\Request Execution Time" "\ASP.NET\Application Restarts" "\ASP.NET\Request Wait Time" "\ASP.NET\Requests Current" "\ASP.NET\Requests Queued" "\ASP.NET\Requests Rejected" "\ASP.NET\Worker Process Restarts" "\Cache\Dirty Pages" "\Cache\Lazy Write Flushes/sec" "\IPv4\Datagrams/sec" "\IPv6\Datagrams/sec" "\LogicalDisk(*)\% Free Space" "\LogicalDisk(*)\% Idle Time" "\LogicalDisk(*)\Avg. Disk Bytes/Read" "\LogicalDisk(*)\Avg. Disk Bytes/Transfer" "\LogicalDisk(*)\Avg. Disk Bytes/Write" "\LogicalDisk(*)\Avg. Disk Queue Length" "\LogicalDisk(*)\Avg. Disk sec/Read" "\LogicalDisk(*)\Avg. Disk sec/Transfer" "\LogicalDisk(*)\Avg. Disk sec/Write" "\LogicalDisk(*)\Current Disk Queue Length" "\LogicalDisk(*)\Disk Bytes/sec" "\LogicalDisk(*)\Disk Reads/sec" "\LogicalDisk(*)\Disk Transfers/sec" "\LogicalDisk(*)\Disk Writes/sec" "\LogicalDisk(*)\Free Megabytes" "\Memory\% Committed Bytes In Use" "\Memory\Available MBytes" "\Memory\Cache Bytes" "\Memory\Commit Limit" "\Memory\Committed Bytes" "\Memory\Free & Zero Page List Bytes" "\Memory\Free System Page Table Entries" "\Memory\Long-Term Average Standby Cache Lifetime (s)" "\Memory\Page Reads/sec" "\Memory\Pages Input/sec" "\Memory\Pages Output/sec" "\Memory\Pages/sec" "\Memory\Pool Nonpaged Bytes" "\Memory\Pool Paged Bytes" "\Memory\Pool Paged Resident Bytes" "\Memory\System Cache Resident Bytes" "\Memory\Transition Faults/sec" "\Memory\Transition Pages RePurposed/sec" "\MSExchange ActiveSync\Average Request Time" "\MSExchange ActiveSync\Ping Commands Pending" "\MSExchange ActiveSync\Requests/sec" "\MSExchange ActiveSync\Sync Commands/sec" "\MSExchange ADAccess Caches(*)\LDAP Searches/Sec" "\MSExchange ADAccess Domain Controllers(*)\LDAP Read calls/Sec" "\MSExchange ADAccess Domain Controllers(*)\LDAP Read Time" "\MSExchange ADAccess Domain Controllers(*)\LDAP Search calls/Sec" "\MSExchange ADAccess Domain Controllers(*)\LDAP Search Time" "\MSExchange ADAccess Domain Controllers(*)\LDAP Searches timed out per minute" "\MSExchange ADAccess Domain Controllers(*)\Long running LDAP operations/Min" "\MSExchange ADAccess Processes(*)\LDAP Read Time" "\MSExchange ADAccess Processes(*)\LDAP Search Time" "\MSExchange Availability Service\Availability Requests (sec)" "\MSExchange Availability Service\Average Number of Mailboxes Processed per Request" "\MSExchange Availability Service\Average Time to Process a Cross-Forest Free Busy Request" "\MSExchange Availability Service\Average Time to Process a Cross-Site Free Busy Request" "\MSExchange Availability Service\Average Time to Process a Free Busy Request" "\MSExchange Availability Service\Average Time to Process a Meeting Suggestions Request" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\I/O Database Reads Average Latency" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\I/O Database Reads/sec" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\I/O Database Writes Average Latency" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\I/O Database Writes/sec" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\I/O Log Reads/sec" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\I/O Log Writes/sec" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\Log Generation Checkpoint Depth" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\Log Record Stalls/sec" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\Log Threads Waiting" "\MSExchange Database ==> Instances(edgetransport/Transport Mail Database)\Version buckets allocated" "\MSExchange Database(edgetransport)\Database Page Fault Stalls/sec" "\MSExchange Extensibility Agents(*)\Average Agent Processing Time (sec)" "\MSExchange Extensibility Agents(*)\Total Agent Invocations" "\MSExchange OWA\Active Conversions" "\MSExchange OWA\Average Conversion Time" "\MSExchange OWA\Average Response Time" "\MSExchange OWA\Average Search Time" "\MSExchange OWA\Current Unique Users" "\MSExchange OWA\Queued Conversion Requests" "\MSExchange OWA\Requests/sec" "\MSExchange Store Driver(_total)\Inbound: LocalDeliveryCallsPerSecond" "\MSExchange Store Driver(_total)\Inbound: MessageDeliveryAttempts" "\MSExchange Store Driver(_total)\Inbound: MessageDeliveryAttemptsPerSecond" "\MSExchange Store Driver(_total)\Inbound: Recipients Delivered Per Second" "\MSExchange Store Driver(_total)\Outbound: Submitted Mail Items Per Second" "\MSExchange Store Interface(*)\ConnectionCache active connections" "\MSExchange Store Interface(*)\ConnectionCache out of limit creations" "\MSExchange Store Interface(*)\ROP Requests outstanding" "\MSExchange Store Interface(*)\RPC Requests failed (%)" "\MSExchange Store Interface(*)\RPC Requests outstanding" "\MSExchange Store Interface(*)\RPC Requests sent/sec" "\MSExchange Store Interface(*)\RPC Slow requests (%)" "\MSExchange Store Interface(*)\RPC Slow requests latency average (msec)" "\MSExchange Store Interface(_Total)\RPC Latency average (msec)" "\MSExchangeAutodiscover\Requests/sec" "\MSExchangeFDS:OAB(*)\Download Task Queued" "\MSExchangeFDS:OAB(*)\Download Tasks Completed" "\MSExchangeFDS:UM\Download Task Queued" "\MSExchangeImap4\Average Command Processing Time (milliseconds)" "\MSExchangeImap4\Current Connections" "\MSExchangePop3\Average Command Processing Time (milliseconds)" "\MSExchangePop3\Connections Current" "\MSExchangeTransport Batch Point(*)\Transactions committed/sec" "\MSExchangeTransport Database(*)\MailItem begin commit/sec" "\MSExchangeTransport Database(*)\Stream read/sec" "\MSExchangeTransport Database(*)\Stream writes/sec" "\MSExchangeTransport Dumpster\Dumpster Deletes/sec" "\MSExchangeTransport Dumpster\Dumpster Inserts/sec" "\MSExchangeTransport Dumpster\Dumpster Item Count" "\MSExchangeTransport Dumpster\Dumpster Size" "\MSExchangeTransport Queues(_total)\Active Mailbox Delivery Queue Length" "\MSExchangeTransport Queues(_total)\Active Non-Smtp Delivery Queue Length" "\MSExchangeTransport Queues(_total)\Active Remote Delivery Queue Length" "\MSExchangeTransport Queues(_total)\Aggregate Delivery Queue Length (All Queues)" "\MSExchangeTransport Queues(_total)\Largest Delivery Queue Length" "\MSExchangeTransport Queues(_total)\Messages Completed Delivery Per Second" "\MSExchangeTransport Queues(_total)\Messages Queued for Delivery Per Second" "\MSExchangeTransport Queues(_total)\Messages Submitted Per Second" "\MSExchangeTransport Queues(_total)\Poison Queue Length" "\MSExchangeTransport Queues(_total)\Retry Mailbox Delivery Queue Length" "\MSExchangeTransport Queues(_total)\Retry Non-Smtp Delivery Queue Length" "\MSExchangeTransport Queues(_total)\Retry Remote Delivery Queue Length" "\MSExchangeTransport Queues(_total)\Submission Queue Length" "\MSExchangeTransport Queues(_total)\Unreachable Queue Length" "\MSExchangeTransport SmtpReceive(_total)\Average bytes/message" "\MSExchangeTransport SmtpReceive(_total)\Messages Received/sec" "\MSExchangeTransport SmtpSend(_total)\Messages Sent/sec" "\MSExchangeWS\Requests/sec" "\Network Inspection System\Average inspection latency (sec/bytes)" "\Network Interface(*)\Bytes Received/sec" "\Network Interface(*)\Bytes Sent/sec" "\Network Interface(*)\Bytes Total/sec" "\Network Interface(*)\Current Bandwidth" "\Network Interface(*)\Output Queue Length" "\Network Interface(*)\Packets Outbound Errors" "\Network Interface(*)\Packets Received/sec" "\Network Interface(*)\Packets Sent/sec" "\Network Interface(*)\Packets/sec" "\Paging File(*)\% Usage" "\Paging File(*)\% Usage Peak" "\PhysicalDisk(*)\Avg. Disk Queue Length" "\PhysicalDisk(*)\Avg. Disk sec/Read" "\PhysicalDisk(*)\Avg. Disk sec/Write" "\PhysicalDisk(*)\Current Disk Queue Length" "\PhysicalDisk(*)\Disk Bytes/sec" "\Process(*)\% Processor Time" "\Process(*)\Handle Count" "\Process(*)\IO Data Operations/sec" "\Process(*)\IO Other Operations/sec" "\Process(*)\Private Bytes" "\Process(*)\Thread Count" "\Process(*)\Virtual Bytes" "\Process(*)\Working Set" "\Process(EdgeTransport)\IO Data Bytes/sec" "\Process(EdgeTransport)\IO Read Bytes/sec" "\Process(EdgeTransport)\IO Write Bytes/sec" "\Processor Information(*)\% DPC Time" "\Processor Information(*)\% Interrupt Time" "\Processor Information(*)\% of Maximum Frequency" "\Processor Information(*)\% Privileged Time" "\Processor Information(*)\% Processor Time" "\Processor Information(*)\% User Time" "\Processor Information(*)\DPC Rate" "\Processor Information(*)\Parking Status" "\Processor(*)\% DPC Time" "\Processor(*)\% Interrupt Time" "\Processor(*)\% Privileged Time" "\Processor(*)\% Processor Time" "\Processor(*)\% User Time" "\Processor(*)\DPC Rate" "\Server\Pool Nonpaged Failures" "\Server\Pool Paged Failures" "\System\Context Switches/sec" "\System\Processor Queue Length" "\System\System Calls/sec" "\TCPv4\Connection Failures" "\TCPv4\Connections Established" "\TCPv4\Connections Reset" "\TCPv4\Segments Received/sec" "\TCPv6\Connection Failures" "\TCPv6\Connections Established" "\TCPv6\Connections Reset" "\TCPv6\Segments Received/sec" "\Web Service(_Total)\Connection Attempts/sec" "\Web Service(_Total)\Current Connections" "\Web Service(_Total)\ISAPI Extension Requests/sec" "\Web Service(_Total)\Other Request Methods/sec"'
