$numerokb = "KB4467706"
$sistemaoperativo = "Windows Server 2008 for x64-based Systems"

$a = Get-KBID -KBNumber $numerokb -OSSupport $sistemaoperativo

$b = Get-SuperSeededByKB -IdKB $a.id -OSSupport $sistemaoperativo


foreach ($i in $b) {
    
    $c = Get-SuperSeededByKB -IdKB (Get-KBID -KBNumber $i -OSSupport $sistemaoperativo).id -OSSupport $sistemaoperativo
    
    $c

 }


#Ejemplo de OS
#2018-07 Security Update for Windows Server 2008 for x86-based Systems (KB4339291)      adf2fae3-4f80-442d-a698-8a4bb513dbfc
#2018-07 Security Update for Windows Server 2008 for Itanium-based Systems (KB4339291)  d8f636d2-1021-425e-a021-6f5552b324da
#2018-07 Security Update for Windows Server 2008 for x64-based Systems (KB4339291)      07ef873f-fc26-45b4-8c03-890d359f2776
#2018-07 Security Update for WES09 and POSReady 2009 for x86-based Systems (KB4339291)  95b79387-5fa5-4e7b-a312-8c458a878eae


function Get-KBID {
param( $KBNumber, $OSSupport )
#

$kbObj = Invoke-WebRequest -Uri "http://www.catalog.update.microsoft.com/Search.aspx?q=$($KBNumber)" 

$Available_KBIDs = $kbObj.InputFields | 
    Where-Object { $_.type -eq 'Button' -and $_.Value -eq 'Download' } | 
    Select-Object -ExpandProperty  ID

$kbGUIDs = $kbObj.Links | Where-Object ID -match '_link' | Select-Object innerHTML,id 

    foreach ($kabe in $kbGUIDs) {
    $kabe.id = $kabe.id.replace('_link','')
    }

$kbfinal = $kbguids | Where-Object {$_.innerHTML -match $OSSupport }

return $kbfinal

}


function Get-SuperSeededByKB {
param( $IdKB, $OSSupport )
#

    $kbObjDetail = Invoke-WebRequest -Uri "https://www.catalog.update.microsoft.com/ScopedViewInline.aspx?updateid=$($IdKB)"

    $ReplacingKB = $kbObjDetail.Links | Where-Object {$_.innerText -match $OSSupport} | Select-Object innerText

    foreach ($update in $ReplacingKB) {

        $regex = [regex]"\((.*)\)"

        $update.innertext = [regex]::match($update.innertext, $regex).Groups[1]
    }
    
    return $ReplacingKB
}