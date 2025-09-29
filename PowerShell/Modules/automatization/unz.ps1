function UZCompilation {
  param(
    [string]$Origin,
    [string]$Destination
  )
  $ZFile = Get-ChildItem -Path $Origin -Filter "*.7z" | Select-Object -ExpandProperty FullName

  . "$CPath/7z.exe" x $ZFile -o"$Destination"
}
