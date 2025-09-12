# [---------- Temp Variables ----------]
#
$REPODIR = Get-Location
$SHARED = "$REPODIR/shared"
$WIN = "$REPODIR/windows"
# $HOMEDIR = "" #Own Home Directory
$PSD_OLD = ""


# [---------- Symbolic Directories ----------]
#
Write-Host "[---------- Symbolic Directories ----------]"
# Powershell
$PSD_OLD = Read-Host "Write the current PowerShell Path"
rm $PSD_OLD -Force -Recurse
New-Item -ItemType Junction -Path $PSD_OLD -Target "$WIN/PowerShell/"

# Nvim
if(Test-Path -Path "$env:LOCALAPPDATA/nvim/") { rm "$env:LOCALAPPDATA/nvim/" -Force -Recurse }
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA/nvim" -Target "$SHARED/nvim/"

# Alacritty
if(Test-Path -Path "$env:APPDATA/alacritty/") { rm "$env:APPDATA/alacritty/" -Force -Recurse }
New-Item -ItemType Junction -Path "$env:APPDATA/alacritty/" -Target "$WIN/alacritty/"


# [---------- Adding the NerdFont ----------]
#
Write-Host "[---------- NerdFonts Added ----------]"
cp "$SHARED/Fonts/CaskaydiaCove/*" "C:/Windows/Fonts/"



# [---------- Conf.json ----------]
#
Write-Host "[---------- Work Directories ----------]"
Write-Host ""
$CONF = [PSCustomObject]@{
  homedir = Read-Host "Write the path that use like a Home Directory"
  devdir  = Read-Host "Write the path that use like a Dev Directory"
  pwsdir  = "$WIN/PowerShell/"
  vidir   = "$env:LOCALAPPDATA/nvim"
}
ConvertTo-Json -Depth 2 $CONF | Out-File "$WIN/PowerShell/conf.json" -Encoding utf8

# [---------- Dependencies ----------]
#
Write-Host "[---------- Dependencies ----------]"

Write-Host ""
Write-Host "List: "

Write-Host "`t>> scoop"
Write-Host "`t>> chocolatey"

Write-Host "`t>> git"
Write-Host "`t>> nvim"
Write-Host "`t>> eza"
Write-Host "`t>> ripgrep"
Write-Host "`t>> MSYS2"
Write-Host "`t>> eza"


Write-Host "`t>> rust"
$url = "https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe"
$output = "$env:USERPROFILE\Downloads\rustup-init.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process $output -Wait


Write-Host "`t>> golang(latest version)"
./windows/goInstaller.ps1


Write-Host "`t>> dotnet(any version)"
[float]$DN_Version = Read-Host "Write the dotnet version(e.g. 8.0)"
./windows/dotnetInstaller.ps1 -Channel $DN_Version



# [---------- Ignore Files ----------]
#
git update-index --assume-unchanged .\shared\nvim\lazy-lock.json



# [---------- Remove Temp Variables ----------]
#
Remove-Variable WIN -ErrorAction SilentlyContinue
Remove-Variable SHARED -ErrorAction SilentlyContinue
Remove-Variable REPODIR -ErrorAction SilentlyContinue
Remove-Variable CONF -ErrorAction SilentlyContinue




