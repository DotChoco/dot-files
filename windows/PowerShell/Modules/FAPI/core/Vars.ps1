[int]$global:SID   = "" #Server ID
[int]$global:SAUTH = "" #Server Auth
$global:ANAME      = "" #Auth Name
$global:ADESC      = "" #Auth Description
$global:CID        = "" #Client ID
$global:CSEC       = "" #Client Secret
$global:ATOK       = "" #Access Token
$global:RTOK       = "" #Refresh Token
$script:AuthsPath  = "$PSScriptRoot/conf.json" #Config Path


$URLMAP = @{
  0 = "https://local.liondev.com.mx:446"
  1 = "https://app.facture.com.mx"
  2 = "https://app.micontador.mx"
}

function GetServerAuth{
  $server = if ($URLMAP.ContainsKey($global:SAUTH)) { $URLMAP[$global:SAUTH] } else { $URLMAP[1] }
  return $server
}



function SelectAuth{
  param([int]$index)

  # Config file Auth Apps
  $Auths = Get-Content -Path $AuthsPath -Raw | ConvertFrom-Json
  $global:SID   = $Auths[$index].sid
  $global:SAUTH = $Auths[$index].sauth
  $global:ANAME = $Auths[$index].name
  $global:ADESC = $Auths[$index].desc
  $global:CID   = $Auths[$index].cid
  $global:CSEC  = $Auths[$index].csec
  $global:ATOK  = $Auths[$index].atok
  $global:RTOK  = $Auths[$index].rtok
}


function ShowAuths{
  param([int]$id = -1)
  # Config file Auth Apps
  $Auths = Get-Content -Path $AuthsPath -Raw | ConvertFrom-Json

  # $AuthsFiltered = FilterAuths $Auths
  # $AuthsFiltered = $Auths
  $SAUTHMAP = @{
    0 = "Local"
    1 = "Production"
    2 = "MiContador"
  }



  function Authsprinter{
    param([int]$i)
    $ServerName = if ($SAUTHMAP.ContainsKey([int]$Auths[$i].sauth)) { $SAUTHMAP[[int]$Auths[$i].sauth] } else { $SAUTHMAP[1] }
    Write-Host "-----------------"
    Write-Host "ID:" $Auths[$i].sid
    Write-Host "Server:" $ServerName
    Write-Host "Name:" $Auths[$i].name
    Write-Host "Description:" $Auths[$i].desc
    Write-Host "Client ID:" $Auths[$i].cid
    Write-Host "Client Secret:" $Auths[$i].csec
  }

  if($id -ge 0 -and $id -lt $Auths.Length){
    Authsprinter $id
  }
  else {
    for ($i = 0; $i -lt $Auths.Length; $i++) {
      Authsprinter $i
    }
  }

  Write-Host "-----------------"
}


function UpdateAuths{
  $Auths = Get-Content -Path $AuthsPath -Raw | ConvertFrom-Json
  for ($i = 0; $i -lt $Auths.Length; $i++) {
    if($Auths[$i].sid -eq $global:SID){
      $Auths[$i].atok  = $global:ATOK
      $Auths[$i].rtok  = $global:RTOK
    }
  }
  ConvertTo-Json -Depth 20 $Auths | Out-File $AuthsPath -Encoding utf8
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




