#Load terminal icons
Import-Module -Name Terminal-Icons

#Turn on the dropdown with the similar recent commands
Set-PSReadLineOption -PredictionViewStyle ListView

# Global Variables
$HOMEDIR = "E:/carlo"
$PWSDIR = "$HOMEDIR/Documents/PowerShell"
$UTILSDIR = "$PWSDIR/utils"


# System
. "$UTILSDIR/system/main.ps1"

# Maths
. "$UTILSDIR/maths/main.ps1"

# Styles
. "$UTILSDIR/styles/main.ps1"

# Testing
. "$UTILSDIR/testing/main.ps1"


clear
