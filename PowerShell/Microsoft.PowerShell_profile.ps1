#Turn on the dropdown with the similar recent commands
Set-PSReadLineOption -PredictionViewStyle ListView

# Global Variables
$HOMEDIR = "E:/carlo"
$PWSDIR = "$HOMEDIR/Documents/PowerShell"
$DEVDIR = "D:/Github"
$VIDIR = "$env:LOCALAPPDATA/nvim"
$BAKDIR = "$DEVDIR/dot-files"
$CONTADIR="$PWSDIR/Modules/Contability"


# Imports
Import-Module System -Force
Import-Module Styles -Force
Import-Module Maths -Force
Import-Module Contability -Force
Import-Module Testing -Force

Remove-Variable BasePath -ErrorAction SilentlyContinue

# clear
