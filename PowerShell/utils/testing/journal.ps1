## Create Bita
function bk{
  $CurrentPath = (Get-Location).Path + "\"
  $BitaPath = $CurrentPath + "Bita-Logs\"
  mkdir $BitaPath
  cd "Bita-Logs"
  $CurrentPath = (Get-Location).Path + "\"
  $ErrPath = $CurrentPath + "Errs\"
  $LogsPath = $CurrentPath + "Logs\"
  mkdir $ErrPath
  mkdir $LogsPath
}

## Bita Logs
function bt{
 param(
    [Parameter(Mandatory = $true)]
    [int]$logType,

    [string]$File
  )

  $Today = Get-Date -Format "ddMM"
  $LFC = ""
  $FileName = ""
  $CurrentPath = ""

  if ([string]::IsNullOrEmpty($File)) { $finalName = $Today } else { $finalName = $File }


  function errorLog {
    #Log File Content
    $LFC = "# Error " + $finalName
    $FileName = "Err_" + $finalName + ".md"
    $CurrentPath = Join-Path -Path (Get-Location) -ChildPath $FileName
    Add-Content -Path $CurrentPath -Value $LFC
  }

  function normalLog {
    $LFC = "# Log " + $finalName
    $FileName = "Log_" + $finalName + ".md"
    $CurrentPath = Join-Path -Path (Get-Location) -ChildPath $FileName
    Add-Content -Path $CurrentPath -Value $LFC
  }

  function suggestLog {
    $LFC = "# Suggest " + $finalName
    $FileName = "Sug_" + $finalName + ".md"
    $CurrentPath = Join-Path -Path (Get-Location) -ChildPath $FileName
    Add-Content -Path $CurrentPath -Value $LFC
  }

  # Lógica según tipo de log
  switch ($logType) {
    0 { errorLog }
    1 { normalLog }
    2 { suggestLog }
    default { Write-Error "Tipo de log no válido. Usa 0 (Error), 1 (Normal), o 2 (Suggest)." }
  }
  return $CurrentPath
}


