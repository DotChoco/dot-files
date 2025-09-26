
# [---------- Symbolic Directories ----------]
#
Write-Host "[---------- Symbolic Directories ----------]"

# Powershell
$PSD_OLD = Read-Host "Write the current PowerShell Path"
Remove-Item $PSD_OLD -Force -Recurse
New-Item -ItemType Junction -Path $PSD_OLD -Target "$(Get-Location)/PowerShell/"

#Windows Terminal
Remove-Item cd "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
New-Item -ItemType Junction -Path $PSD_OLD -Target "$(Get-Location)/LocalState/"

# Nvim
if(Test-Path -Path "$env:LOCALAPPDATA/nvim/") { Remove-Item "$env:LOCALAPPDATA/nvim/" -Force -Recurse }
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA/nvim" -Target "$(Get-Location)/nvim/"

# Alacritty
if(Test-Path -Path "$env:APPDATA/alacritty/") { Remove-Item "$env:APPDATA/alacritty/" -Force -Recurse }
New-Item -ItemType Junction -Path "$env:APPDATA/alacritty/" -Target "$WIN/alacritty/"

Write-Host "`n`n`n`n"



# [---------- Config Directories ----------]
#
Write-Host "[---------- Config Directories ----------]"
Write-Host ""
$CONF = [PSCustomObject]@{
  homedir = Read-Host "Write the path that use like a Home Directory"
  devdir  = Read-Host "Write the path that use like a Dev Directory"
  pwsdir  = "$(Get-Location)/PowerShell/"
  vidir   = "$env:LOCALAPPDATA/nvim"
}
ConvertTo-Json -Depth 2 $CONF | Out-File "$env:LOCALAPPDATA/PowerShell/conf.json" -Encoding utf8

Write-Host "`n`n`n`n"



# [---------- Dependencies ----------]
#
Write-Host "[---------- Dependencies ----------]"

Write-Host ""
Write-Host "List: "

Write-Host "  >> Scoop"
Write-Host "  >> chocolatey"
Write-Host "  >> git"
Write-Host "  >> nodejs"
Write-Host "  >> nvim"
Write-Host "  >> eza"
Write-Host "  >> ripgrep"
Write-Host "  >> MSYS2"



$Git = Read-Host "Do you want install git(y/n)?"
if($Git.ToLower() -eq "y"){
  winget install --id Git.Git -e --source winget
}


$Scoop = Read-Host "Do you want install scoop(y/n)?"
if($Scoop.ToLower() -eq "y" -or $Scoop -eq ""){
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}


$Chocolatey = Read-Host "Do you want install chocolatey(y/n)?"
if($Chocolatey.ToLower() -eq "y"){
  powershell -c "irm https://community.chocolatey.org/install.ps1|iex"
}


$NodeJs = Read-Host "Do you want install nodeJs(y/n)?"
if($NodeJs.ToLower() -eq "y"){
  choco install nodejs-lts
}


$Nvim = Read-Host "Do you want install neovim(y/n)?"
if($Nvim.ToLower() -eq "y"){
  winget install Neovim.Neovim
}


$Eza = Read-Host "Do you want install eza(y/n)?"
if($Eza.ToLower() -eq "y"){
  scoop install eza
}


$ripgrep = Read-Host "Do you want install ripgrep(y/n)?"
if($ripgrep.ToLower() -eq "y"){
  choco install ripgrep
}


$MSYS2 = Read-Host "Do you want install MSYS2(y/n)?"
if($MSYS2.ToLower() -eq "y"){
  winget install MSYS2.MSYS2
}

Write-Host "`n`n`n`n"




# [---------- Adding the NerdFont ----------]
#
Write-Host "[---------- NerdFonts Added ----------]"
scoop bucket add nerd-fonts
scoop install CascadiaCode-NF

Write-Host "`n`n`n`n"




# [---------- Dependencies ----------]
#
Write-Host "[---------- Languajes ----------]"
$Rust = Read-Host "Do you want install Rust(y/n)?"
if($Rust.ToLower() -eq "y"){
  $url = "https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe"
  $output = "$env:USERPROFILE\Downloads\rustup-init.exe"
  Invoke-WebRequest -Uri $url -OutFile $output
  Start-Process $output -Wait
}


# $Go = Read-Host "Do you want install Golang(y/n)?"
# if($Go.ToLower() -eq "y"){
#   # Write-Host "`t>> golang(latest version)"
#   ./installers/goInstaller.ps1
# }


# $CSharp = Read-Host "Do you want install CSharp(y/n)?"
# if($CSharp.ToLower() -eq "y"){
#   Write-Host "`t>> dotnet(any version)"
#   [float]$DN_Version = Read-Host "Write the dotnet version(e.g. 8.0)"
#   ./installers/dotnetInstaller.ps1 -Channel $DN_Version
# }

Write-Host "`n`n`n`n"



# [---------- Restart Windows Terminal ----------]
Write-Host "You need restart your terminal to apply the changes."
$Restart = Read-Host "Do you want restart it now?"

if($Restart.ToLower() -eq "y"){
  Start-Process wt
  Stop-Process -Id (Get-Process -Id $PID).Parent.Id
}


