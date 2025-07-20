function bakps {
  $Target = "$BAKDIR/PowerShell"
  param ([string]$Destiny = $BAKDIR)

  #Go to dot-files dir
  cd $BAKDIR

  #Replace the PowerShell Folder
  fr $Target
  ffc $PWSDIR $Target

  fcm
}


function bakvi {
  $Target = "$BAKDIR/nvim"
  param ([string]$Destiny = $BAKDIR)


  #Go to dot-files dir
  cd $BAKDIR

  #Replace the PowerShell Folder
  fr $Target
  ffc $VIDIR $Target

  fcm
}


