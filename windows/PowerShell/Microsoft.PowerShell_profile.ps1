#Turn on the dropdown with the similar recent commands
Set-PSReadLineOption -PredictionViewStyle ListView


# Config file
$json = Get-Content -Path "$PSScriptRoot/conf.json" -Raw | ConvertFrom-Json

# Global Mutables Variables
$HOMEDIR = $json.homedir
<<<<<<< HEAD
$DEVDIR = $json.devdir
$PWSDIR = $json.pwsdir
$VIDIR = $json.vidir
=======
$DEVDIR  = $json.devdir
$PWSDIR  = $json.pwsdir
$VIDIR   = $json.vidir
>>>>>>> 5f55c4383f937e31cb9dcde091b774d4943a3952

# Global Inmutables Variables
$DFDIR = "$DEVDIR/dot-files"
$CONTADIR = "$PWSDIR/Modules/Contability"
$FAPI = "$PWSDIR/Modules/FAPI"


# Imports
Import-Module System -Force
Import-Module Styles -Force
Import-Module Maths -Force
Import-Module Contability -Force
# Import-Module Testing -Force
Import-Module FAPI -Force

Remove-Variable BasePath -ErrorAction SilentlyContinue

# clear
