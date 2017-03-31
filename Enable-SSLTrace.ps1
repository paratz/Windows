$NetCapFile = $env:SystemRoot + '\temp\netcap.etl'
$StartNetCap = "netsh trace start traceFile=" + $NetCapFile  + " capture=yes maxsize=200 filemode=circular overwrite=yes report=no"