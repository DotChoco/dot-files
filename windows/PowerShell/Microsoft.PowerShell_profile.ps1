#Turn on the dropdown with the similar recent commands
Set-PSReadLineOption -PredictionViewStyle ListView


# Config file
$json = Get-Content -Path "$PSScriptRoot/conf.json" -Raw | ConvertFrom-Json

# Global Mutables Variables
$HOMEDIR = $json.homedir
$DEVDIR = $json.devdir
$PWSDIR = $json.pwsdir

# Global Inmutables Variables
$VIDIR = "$env:LOCALAPPDATA/nvim"
$DFDIR = "$DEVDIR/dot-files"
$CONTADIR = "$PWSDIR/Modules/Contability"
$FAPI = "$PWSDIR/Modules/FAPI"


# Imports
Import-Module System -Force
Import-Module Styles -Force
Import-Module Maths -Force
Import-Module Contability -Force
Import-Module Testing -Force

Remove-Variable BasePath -ErrorAction SilentlyContinue

# clear
