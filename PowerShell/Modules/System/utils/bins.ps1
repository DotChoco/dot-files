# Eza
function tree {
  param (
    [string]$path
  )
  if($path -eq ""){ $path= Get-Location }
  eza -T $path
}



## Typst
function tpr {
  param (
    [string]$path
  )
  typst.exe compile $path
}
function tpv {
  param (
    [string]$path
  )
  typst.exe watch $path
}



# SPOT
function spd {
  param (
    [Parameter(Mandatory=$true)] # Makes the parameter required
    [string]$spotifyURL
  )
  python.exe -m spotdl --output "$HOMEDIR/Musica/{artist}-{title}.mp3" $spotifyURL
}

Set-Alias tre tree
Set-Alias ob obsidian
Set-Alias g git
