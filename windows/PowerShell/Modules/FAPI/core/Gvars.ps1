$SAUTH = "" #Server Auth
$ANAME = "" #Client ID
$ADESC = "" #Client ID
$CID   = "" #Client ID
$CSEC  = "" #Client Secret
$ATOK  = "" #Access Token
$RTOK  = "" #Refresh Token

function SelectAuth{
  param([int]$index)
  # Config file Auth Apps
  $Auths = Get-Content -Path "$PSScriptRoot/conf.json" -Raw | ConvertFrom-Json

  $script:SAUTH = $Auths[$index].sauth
  $script:ANAME = $Auths[$index].name
  $script:ADESC = $Auths[$index].desc
  $script:CID   = $Auths[$index].cid
  $script:CSEC  = $Auths[$index].csec
  $script:ATOK  = $Auths[$index].atok
  $script:RTOK  = $Auths[$index].rtok

}


function PrintAuths{
  # Config file Auth Apps
  $Auths = Get-Content -Path "$PSScriptRoot/conf.json" -Raw | ConvertFrom-Json

  # $AuthsFiltered = FilterAuths $Auths
  $AuthsFiltered = $Auths
  $SAUTHMAP = @{
    0 = "Local"
    1 = "Production"
    2 = "MiContador"
  }
  for ($i = 0; $i -lt $AuthsFiltered.Length; $i++) {
    $ServerName = if ($SAUTHMAP.ContainsKey($SAUTH)) { $SAUTHMAP[$SAUTH] } else { $SAUTHMAP[1] }
    Write-Host "-----------------"
    Write-Host "Server:" $ServerName
    Write-Host "Name:" $AuthsFiltered[$i].name
    Write-Host "Description:" $AuthsFiltered[$i].desc
    Write-Host "Client ID:" $AuthsFiltered[$i].cid
    Write-Host "Client Secret:" $AuthsFiltered[$i].csec
  }
  Write-Host "-----------------"

}

function FilterAuths{
  param([object[]]$auths)
  $authsName = FilterAuthsN $auths
  $authsName = FilterAuthsN $auths
  $authsName = FilterAuthsN $auths

}


function ClearAuth{
  $script:SAUTH = ""
  $script:ANAME = ""
  $script:ADESC = ""
  $script:CID   = ""
  $script:CSEC  = ""
  $script:ATOK  = ""
  $script:RTOK  = ""
}

$URLMAP = @{
  0 = "https://local.liondev.com.mx"
  1 = "https://app.facture.com.mx"
  2 = "https://app.micontador.mx"
}


