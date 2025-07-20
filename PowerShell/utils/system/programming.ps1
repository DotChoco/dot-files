# Cmake
function cmm {
  $dir_build= (Get-Location).Path + "\build\"
  $exist_dir = Test-PathExists $dir_build

  if($exist_dir -eq $true){ rm $dir_build -Force -Recurse }

  mkdir $dir_build
  cd build/

  cmake .. -G "Ninja"
  cmake --build .

  cd ../
}



# Git
function gts { git status }
function gta { git add .} # Git add All
function gtp { git push }
function gtpl { git pull }

#Git Commit
function gtm {
  param([string]$comment)
  if($comment -eq ""){ $comment = "f: menor update" }
  git commit -m $comment
}

#Git Log
function gtl {
  param([int]$index)
  if($index -eq 0){ git log }
  else { git log -$index }
}

#Fast Commit
function fcm {
  param([string]$comment)
  gta && gtm $comment && gtp
}


# SPOT
function spd {
  param (
    [Parameter(Mandatory=$true)] # Makes the parameter required
    [string]$spotifyURL
  )
  python.exe -m spotdl download $spotifyURL
}

#CPP
function cr {
  param (
    [string]$path,
    [string]$name
  )
  if($path -eq ""){ $path = Get-Location }
  if($name -eq ""){ $name = "DebugApp.exe" }
  g++.exe -o $path $name
}

function crb {
  param (
    [string]$OutputName = "program",
    [string]$ProjectRoot = "."
  )
  if($ProjectRoot -eq ""){ $ProjectRoot = (Get-Location).Path + "\src\main.cpp" }
  if($OutputName -eq ""){ $OutputName = "DebugApp.exe" }
  g++.exe -o $OutputName $ProjectRoot\src\main.cpp
}


# Go
# Go Run
function gor {
  param (
    [string]$path
  )
  if($ProjectRoot -eq ""){ $ProjectRoot = (Get-Location).Path + "\main.go" }
  go.exe run $path
}



# Eza
function tree {
  param (
    [string]$path
  )
  if($path -eq ""){ $path= Get-Location }
  eza -T $path
}

## Typst
function tpr {
  param (
    [string]$path
  )
  typst.exe compile $path
}

function tpv {
  param (
    [string]$path
  )
  typst.exe watch $path
}


## Dotnet
function dnbr { dotnet build -c Release }
function dnb { dotnet build }
function dnr { dotnet run }
function dnrr { dotnet run --configuration Release }


## PHP
function plh {
  param (
    [int]$port
  )
  php -S localhost:$port
}

#Apache Server
#Stop
function assp { httpd -k stop }
#Start
function asst { httpd -k start }
#Restart
function asrs { httpd -k restart }


# Linux
function lnh { wsl.exe --cd "~" }


# Alias
Set-Alias lnx  wsl.exe
Set-Alias vi nvim
Set-Alias sr surreal.exe # Surreal


