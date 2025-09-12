
function GetAuthScopes{
  Write-Host "-----------------"
  Write-Host "cliente"
  Write-Host "concepto"
  Write-Host "emisor"
  Write-Host "sucursal"
  Write-Host "serie"
  Write-Host "moneda"
  Write-Host "impuesto"
  Write-Host "timbrado"
  Write-Host "facturacion"
  Write-Host "cancelacion"
  Write-Host "item_usuario"
  Write-Host "autofactura"
  Write-Host "descarga_masiva"
  Write-Host "comprobante_recibido"
  Write-Host "-----------------"
}

$script:SCOPES = ""

function AuthAPP{
  param(
    [Parameter(Mandatory=$true)]
    [string]$authcode
  )

  $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $headers.Add("Content-Type", "application/x-www-form-urlencoded")
  $URI = GetServerAuth
  $body = "client_id=" + $CID + "&client_secret=" + $CSEC
  $AUTHORIZE = $URI + "/api/authorize?grant_type=authorization_code&redirect_uri=http://localhost&code=" + $authcode + "&scope=" + $SCOPES

  $response = Invoke-RestMethod $AUTHORIZE -Method 'POST' -Headers $headers -Body $body

  $global:ATOK = $response.access_token
  $global:RTOK = $response.refresh_token

  $response | ConvertTo-Json

  UpdateAuths

  $script:SCOPES = ""
}


function AccountAuth{
  param(
    [Parameter(Mandatory=$true)]
    [string]$Scopes
  )
  $script:SCOPES = $scopes

  $URI = GetServerAuth
  $LoginUrl = $URI + "/ws/login.jsp?redirect_uri=http://localhost&response_type=code&client_id=" + $CID + "&scope=" + $scopes
  Start-Process $LoginUrl
}

function AutoAuth{
  param(
    [Parameter(Mandatory=$true)]
    [string]$Scopes,

    [Parameter(Mandatory=$true)]
    [string]$User,

    [Parameter(Mandatory=$true)]
    [string]$Pss
  )

  if (-not (Get-Module Selenium)) {
    $customPath = "D:/Testing/Selenium/"
    [System.Environment]::SetEnvironmentVariable("PSModulePath", $env:PSModulePath + ";" + $customPath, "User")
    Import-Module Selenium
  }

  $chromeArgs = @(
    "--disable-gpu",
    "--window-size=1200,800",
    "--headless"        # <- Hide the google chrome
  )

  $script:SCOPES = $scopes
  $URI = GetServerAuth
  $LoginUrl = $URI + "/ws/login.jsp?redirect_uri=http://localhost&response_type=code&client_id=" + $CID + "&scope=" + $scopes

  $Driver = Start-SeChrome -BinaryPath "C:/Program Files/Google/Chrome/Application/chrome.exe" -StartURL $LoginUrl -Arguments $chromeArgs
  $Driver.FindElementById("login_username").SendKeys($User)
  $Driver.FindElementById("login_password").SendKeys($Pss)

  $Driver.FindElementById("btn_login").Click()

  # ==== AUTHORIZE APP ====
  $Driver.FindElementById("btn_auth").Click()


  # ==== CAPTURE FINAL URL  ====
  Start-Sleep -Seconds 2
  $redirectUrl = $Driver.Url
  $uri = [System.Uri]$redirectUrl
  $queryParams = [System.Web.HttpUtility]::ParseQueryString($uri.Query)
  $code = $queryParams["code"]


  # ==== CLOSE NAVEGATOR ====
  Stop-SeDriver $Driver


  AuthAPP $code
}


function AuthorizeByPss{
  param(
    [Parameter(Mandatory=$true)]
    [string]$Scopes,

    [Parameter(Mandatory=$true)]
    [string]$User,

    [Parameter(Mandatory=$true)]
    [string]$Pss
  )

  $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $headers.Add("Content-Type", "application/x-www-form-urlencoded")

  $body = "username=" + $User + "&password=" + $Pss + "&scope=" + $Scopes + "&client_id=" + $Global:CID + "&client_secret=" + $Global:CSEC
  $URI = GetServerAuth

  $response = Invoke-RestMethod "$URI/api/authorize?grant_type=password" -Method 'POST' -Headers $headers -Body $body
  $response | ConvertTo-Json

  $global:ATOK = $response.access_token
  $global:RTOK = $response.refresh_token

  UpdateAuths
}



function UpdateToken{
  $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $headers.Add("Content-Type", "application/x-www-form-urlencoded")

  $body = "client_id=" + $global:CID + "&client_secret=" + $global:CSEC + "&refresh_token=" + $global:RTOK

  $URI = GetServerAuth
  $response = Invoke-RestMethod "$URI/api/authorize?grant_type=refresh_token" -Method 'POST' -Headers $headers -Body $body

  $global:ATOK = $response.access_token
  $global:RTOK = $response.refresh_token

  $response | ConvertTo-Json

  UpdateAuths
}




