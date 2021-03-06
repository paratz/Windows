﻿cls
$numerokb = Read-Host "Por favor Ingrese el número de KB (KBXXXXXXX) o Boletin de Seguridad (MSXX-XXX)"
"  "
$serverIP = Read-Host "Por favor Ingrese la dirección del servidor"

$kbObj2 = Invoke-WebRequest -Uri "http://www.catalog.update.microsoft.com/Search.aspx?q=$($numerokb)" 

$Available_KBIDs = $kbObj2.InputFields | 
    Where-Object { $_.type -eq 'Button' -and $_.Value -eq 'Download' } | 
    Select-Object -ExpandProperty  ID

$kbGUIDs2 = $kbObj2.Links | Where-Object ID -match '_link' | Select-Object innerHTML,id 

    foreach ($kabe2 in $kbGUIDs2) {
    $kabe2.id = $kabe2.id.replace('_link','')
    }


if ($kbGUIDs2 -eq $Null) {
        "  "

        Write-Host "No se encuentra KB o Boletin de Seguridad" -BackgroundColor Red
        "  "
        exit
  }


$string = $kbGUIDs2.innerHTML | Out-GridView -Title "Seleccione OS" -PassThru

    $regex = [regex]"\((.*)\)"
        
    $kblenght = ([regex]::match($string, $regex).Groups[1])


$sistemaoperativo = $string.Substring(0,$string.Length-$kblenght.Length-4)

" "
"===Buscando KB y sus reemplazantes en Windows Update Catalog ...===="
" "

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

" "
"===Buscando KB instalados en servidor $($serverip) ...===="
" "

$KBInstaladas = Get-HotFix -ComputerName $serverIP
#$KBInstaladas = Import-Csv -Path "C:\Users\paratz.SOUTHAMERICA\Desktop\anses\servidorfavorito.csv"


foreach ($o in $kblist) {

    foreach ($hotfix in $KBInstaladas) {
    
    if ($o.kb -eq $hotfix.hotfixid) {

    $o.description = "INSTALADO - " + $o.description        

    }
 
   }

}

$output = $kblist | foreach { "==="*$_.level + $_.description }

$contar = 0

foreach ($line in $output) {

    if($line -match "INSTALADO") {
    
    Write-Host $line -BackgroundColor Green
    $contar += 1
    
    } else {

    Write-Host $line 

    }

}

if ($contar -eq 0) {

    Write-Host "KB no se encuentra instalado" -BackgroundColor Red

}


