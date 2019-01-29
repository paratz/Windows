﻿$numerokb = "KB2892074"
$sistemaoperativo = "Windows Server 2008 R2 x64 Edition"

$global:kbList = @() 


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
param( $IdKB )
#

    $kbObjDetail = Invoke-WebRequest -Uri "https://www.catalog.update.microsoft.com/ScopedViewInline.aspx?updateid=$($IdKB)"

    $ReplacingKB = $kbObjDetail.Links | Where-Object {$_.innerHTML -match "Update" -or $_.innerHTML -match "Rollup"} | Select-Object innerText

    $ReplacingKB | Add-Member -MemberType NoteProperty "Description" -Value $Null -Force
    
    foreach ($update in $ReplacingKB) {

        $regex = [regex]"\((.*)\)"
        
        $update.Description = $update.innerText

        $update.innertext = [regex]::match($update.innertext, $regex).Groups[1]
    }
    
    return $ReplacingKB
}


function get-innerkb($parentkb, $level, $description)
{
    $global:kbList += New-Object PSCustomObject -prop @{ kb="$parentkb"; level=$level; description=$description}
    
    $a = Get-KBID -KBNumber $parentkb -OSSupport $sistemaoperativo

    if ($a -ne $null)
    {
        #Estoy suponiendo que me llega 1 solo resultado. Sino tengo que hacer un foreach
        $b = Get-SuperSeededByKB -IdKB $a.id -OSSupport $sistemaoperativo
        
        foreach($kb in $b) {
            #validar que no est{e en el kblist
            if ($global:kbList.kb -notcontains $kb.Value)
            { 
                get-innerkb $kb.InnerText ($level + 1) $kb.Description
            }
        }
    }
}

get-innerkb $numerokb 0 (Get-KBID -KBNumber $numerokb -OSSupport $sistemaoperativo).innerHTML

$kblist | foreach { "==="*$_.level + $_.description }
