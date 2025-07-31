$REPODIR = Get-Location
$SHARED = "$REPODIR/shared"
$WIN = Get-Location


# Create the symbolic relation between the powershell directory from the repo and the program path
# New-Item -ItemType Junction -Path $env:LOCALAPPDATA/nvim -Target $WIN/

# Create the symbolic relation between the nvim directory from the repo and the program path
New-Item -ItemType Junction -Path $env:LOCALAPPDATA/nvim -Target "$SHARED/nvim/"
