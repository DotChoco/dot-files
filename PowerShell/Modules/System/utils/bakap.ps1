function bakps {
  param (
    [Parameter(Mandatory=$true)]
    [string]$Destiny
  )

  #Go to dot-files dir
  cd "$DEVDIR/dot-files"

  #Replace the PowerShell Folder
  $CurrentDir = Get-Location
  fr "$CurrentDir/PowerShell"
  ffc $PWSDIR $CurrentDir

  fcm
}


function bakvi {
  param (
    [Parameter(Mandatory=$true)]
    [string]$Destiny
  )

  #Go to dot-files dir
  cd "$CurrentDir/dot-files"

  #Replace the PowerShell Folder
  $CurrentDir = Get-Location
  fr "$CurrentDir/nvim"
  ffc $VIDIR $CurrentDir

  fcm
}


