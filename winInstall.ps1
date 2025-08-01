$REPODIR = Get-Location
$SHARED = "$REPODIR/shared"
$WIN = "$REPODIR/windows"

# Create the symbolic relation between the powershell directory from the repo and the program path
rm "$HOME/Documents/PowerShell/" -Force -Recurse
New-Item -ItemType Junction -Path "$HOME/Documents/PowerShell/" -Target "$WIN/PowerShell\"

# Create the symbolic relation between the nvim directory from the repo and the program path
New-Item -ItemType Junction -Path $env:LOCALAPPDATA/nvim -Target "$SHARED/nvim/"
