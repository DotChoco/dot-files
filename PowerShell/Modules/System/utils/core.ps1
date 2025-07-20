# Functions
function jj { cd "$HOMEDIR/Download"} # home dir
function gg { cd "D:/Github"} # dev dir
function psd { cd $PWSDIR } #Go to the PowerShell Path
function nvc { cd $env:LOCALAPPDATA/nvim } #Go to the Nvim Path
function ~ { jj }
function .. { cd .. } #Make a backward move

function ee { exit } #Close the terminal
function dd { shutdown /s /t 0 } #Shutdown the PC


function ex {
  param([string]$Path)
  if($Path -eq ""){$Path = Get-Location}
  explorer $Path
} #Open File Explorer

# Copy to Clipboard
function cb {
  param (
    [Parameter(Mandatory=$true)] # Makes the parameter required
    [string]$FilePath            # Parameter of type string
  )
  cat $FilePath | scb
}

function Test-PathExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Path # El parámetro que recibirá la ruta a verificar
  )

  if (Test-Path -Path $Path) { return $true}
  else { return $false }
}






# Alias
Set-Alias unzip Expand-Archive
Set-Alias zip Compress-Archive
Set-Alias cls clear
Set-Alias cc clear
Set-Alias mk mkdir
Set-Alias xx ex


