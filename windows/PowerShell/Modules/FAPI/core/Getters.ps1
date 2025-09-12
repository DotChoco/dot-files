
#Get all sucursales from an emisor
function GetSucursal{
  $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $headers.Add("Authorization", "Bearer $ATOK")
  $headers.Add("Accept", "application/json")
  $URI = GetServerAuth
  Write-Host "Sucursales Gotten from '$URI':"
  $response = Invoke-RestMethod "$URI/api/sucursal/find?offset=0&size=10" -Method 'GET' -Headers $headers
  $response | ConvertTo-Json -Depth 20
}

