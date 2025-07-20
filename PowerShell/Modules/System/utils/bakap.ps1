function bakps {
  param ([string]$Destiny = $BAKDIR)
  $Target = "$BAKDIR/PowerShell"

  #Go to dot-files dir
  cd $BAKDIR

  #Replace the PowerShell Folder
  fr $Target
  ffc $PWSDIR $Destiny

  fcm
}


function bakvi {
  param([string]$Destiny = $BAKDIR)
  $Target = "$BAKDIR/nvim"

  #Go to dot-files dir
  cd $BAKDIR

  #Replace the PowerShell Folder
  fr $Target
  ffc $VIDIR $Destiny

  fcm
}


