$REPODIR = Get-Location
$SHARED = "$REPODIR/shared"
$WIN = "$REPODIR/windows"
$HOMEDIR = ""

# Create the symbolic for the powershell directory
rm "$HOMEDIR/Documents/PowerShell/" -Force -Recurse
New-Item -ItemType Junction -Path "$HOMEDIR/Documents/PowerShell/" -Target "$WIN/PowerShell/"

# Create the symbolic relation for the nvim directory
if(Test-Path -Path "$env:LOCALAPPDATA/nvim/") { rm "$env:LOCALAPPDATA/nvim/" -Force -Recurse }
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA/nvim" -Target "$SHARED/nvim/"

# Create the symbolic relation for the Alacritty directory
if(Test-Path -Path "$env:APPDATA/alacritty/") { rm "$env:APPDATA/alacritty/" -Force -Recurse }
New-Item -ItemType Junction -Path "$env:APPDATA/alacritty/" -Target "$WIN/alacritty/"

# Adding the NerdFont
cp "$SHARED/Fonts/CaskaydiaCove/*" "C:/Windows/Fonts/"

# Git will discard all changes that could be made into this files
git update-index --assume-unchanged .\shared\nvim\lazy-lock.json
git update-index --assume-unchanged windows/PowerShell/conf.json

Remove-Variable WIN -ErrorAction SilentlyContinue
Remove-Variable SHARED -ErrorAction SilentlyContinue
Remove-Variable REPODIR -ErrorAction SilentlyContinue
