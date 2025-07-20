#Turn on the dropdown with the similar recent commands
Set-PSReadLineOption -PredictionViewStyle ListView

# Global Variables
$HOMEDIR = "E:/carlo"
$PWSDIR = "$HOMEDIR/Documents/PowerShell"
$DEVDIR = "D:/Github"
$VIDIR = "$env:LOCALAPPDATA/nvim"


# Imports
Import-Module System -Force
Import-Module Styles -Force
Import-Module Maths -Force
Import-Module Testing -Force

Remove-Variable BasePath -ErrorAction SilentlyContinue

# clear
