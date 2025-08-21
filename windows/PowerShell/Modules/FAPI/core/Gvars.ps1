$CID  = "" #Client ID
$CSEC = "" #Client Secret
$ATOK = "" #Access Token
$RTOK = "" #Refresh Token
$SAUTH= "" #Server Auth

function SelectAuth{
  param([int]$index)
  # Config file Auth Apps
  $Auths = Get-Content -Path "$PSScriptRoot/conf.json" -Raw | ConvertFrom-Json

  # $inputStr = Read-Host "Write the index of auth you want to use"
  # Convert to int
  # [int]$index = $inputStr

  $script:CID   = $Auths[$index].cid
  $script:CSEC  = $Auths[$index].csec
  $script:ATOK  = $Auths[$index].atok
  $script:RTOK  = $Auths[$index].rtok
  $script:SAUTH = $Auths[$index].sauth

}

function ClearAuth{
  $script:CID   = ""
  $script:CSEC  = ""
  $script:ATOK  = ""
  $script:RTOK  = ""
  $script:SAUTH = ""
}

$URLMAP = @{
  0 = "https://local.liondev.com.mx"
  1 = "https://app.facture.com.mx"
  2 = "https://app.micontador.mx"
}


