
function ToBase64{
   param(
    [Parameter(Mandatory=$true)]
    [string]$Data
  )
  return [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($Data))
}


function MakeInvoice{
  # Create empty list
  $comprobantes = @()

  do {
    $uuid   = Read-Host "Ingresa requestUuid"
    $encode = Read-Host "Ingresa encode"

    $addItemUsuario = Read-Host "¿Deseas agregar itemUsuario? (s/n)"
    if ($addItemUsuario -eq "s") {
      $itemId   = Read-Host "Ingresa el id del itemUsuario"
      $template = Read-Host "Ingresa el template"
      $comprobantes += @{
        requestUuid = $uuid
        encode      = $encode
        itemUsuario = @{
          id       = [int]$itemId
          template = $template
        }
      }
    }
    else {
      $comprobantes += @{
        requestUuid = $uuid
        encode      = $encode
      }
    }

    $continuar = Read-Host "¿Agregar otro comprobante? (s/n)"
  } while ($continuar -eq "s")

  # Witch sucursal
  $idSucursal = Read-Host "Ingresa el id de la sucursal"

  # Build the json
  $body = @{
    entity = @{
      data = @{
        comprobantes = $comprobantes
        sucursal     = @{
          id = [int]$idSucursal
        }
      }
    }
  }

  return $body
}

function InvoiceToJSON{
  $jsonBody = $body | ConvertTo-Json -Depth 5 -Compress
  $base64 = ToBase64 $jsonBody

  return $base64
}

function InvoiceToXML{
  $jsonBody = $body | ConvertTo-Json -Depth 5 -Compress
  $base64 = ToBase64 $jsonBody

  return $base64
}



function TimbradoXML{
  $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $headers.Add("Authorization", "Bearer ")
  $headers.Add("Accept", "application/json")
  $headers.Add("Content-Type", "application/json")

  # Convert to JSON
  $invoice = MakeInvoice $true
  $body = InvoiceToJSON $invoice
  $URI = GetServerAuth

  $response = Invoke-RestMethod "$URI/api/timbrado" -Method 'POST' -Headers $headers -Body $body
  $response | ConvertTo-Json

}



function TimbradoJSON{
  $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $headers.Add("Authorization", "Bearer ")
  $headers.Add("Accept", "application/json")
  $headers.Add("Content-Type", "application/json")

  # Make the Invoice before
  $invoice = MakeInvoice $true
  $body = InvoiceToXML $invoice
  $URI = GetServerAuth

  $response = Invoke-RestMethod "$URI/api/timbrado/json" -Method 'POST' -Headers $headers -Body $body
  $response | ConvertTo-Json

}



