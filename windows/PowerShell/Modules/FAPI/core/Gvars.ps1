
# Config file Auth Apps
$json = Get-Content -Path "$PSScriptRoot/conf.json" -Raw | ConvertFrom-Json

$CID  = $json.cid
$CSIC = $json.csic
$ATOK = $json.atok
$RTOK = $json.rtok



$URLMAP = @{
  0 = "https://local.liondev.com.mx"
  1 = "https://app.facture.com.mx"
  2 = "https://app.micontador.mx"
}


