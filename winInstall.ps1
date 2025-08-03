$REPODIR = Get-Location
$SHARED = "$REPODIR/shared"
$WIN = "$REPODIR/windows"

# Create the symbolic for the powershell directory
rm "$HOME/Documents/PowerShell/" -Force -Recurse
New-Item -ItemType Junction -Path "$HOME/Documents/PowerShell/" -Target "$WIN/PowerShell/"

# Create the symbolic relation for the nvim directory
if(Test-Path -Path "$env:LOCALAPPDATA/nvim/") { rm "$env:LOCALAPPDATA/nvim/" -Force -Recurse }
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA/nvim" -Target "$SHARED/nvim/"

# Create the symbolic relation for the Alacritty directory
if(Test-Path -Path "$env:APPDATA/alacritty/") { rm "$env:APPDATA/alacritty/" -Force -Recurse }
New-Item -ItemType Junction -Path "$env:APPDATA/alacritty/" -Target "$WIN/alacritty/"

#Adding the NerdFont
cp "$SHARED/Fonts/CaskaydiaCove/*" "C:/Windows/Fonts/"


Remove-Variable WIN -ErrorAction SilentlyContinue
Remove-Variable SHARED -ErrorAction SilentlyContinue
Remove-Variable REPODIR -ErrorAction SilentlyContinue
