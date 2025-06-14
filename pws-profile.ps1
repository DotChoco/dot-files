Import-Module Terminal-Icons
Set-PSReadLineOption -PredictionViewStyle ListView

# Powerline
function global:prompt {
  # Obtener ruta actual con manejo de home directory
  $cwd = $(Get-Location).Path
  if ($cwd -like "$env:USERPROFILE*") {
      $cwd = "~" + $cwd.Substring($env:USERPROFILE.Length)
  }
  $leaf = Split-Path $cwd -Leaf

  # Formatear tiempo
  $time = Get-Date -Format "HH:mm"

  # Definir s├¡mbolos con fallbacks
  $arrow = if ($Host.UI.SupportsVirtualTerminal) {
      "`u{276F}" } else { ">" }

  $gitSymbol = if ($Host.UI.SupportsVirtualTerminal) {
      "`u{E0A0}" } else { "G:" }

  # Colores usando las variables de PowerShell
  $cwdColor = $PSStyle.Foreground.FromRgb(229,192,123)
  $timeColor = $PSStyle.Foreground.FromRgb(152,195,121)
  $gitColor = $PSStyle.Foreground.FromRgb(204,111,130)
  $resetColor = "$([char]27)[0m"

  # Informaci├│n de Git
  $gitBranch = ""
  if (Get-Command git -ErrorAction SilentlyContinue) {
    try {
      $branch = git rev-parse --abbrev-ref HEAD 2>$null
      if ($branch) {
        $gitBranch = " $gitColor$gitSymbol $branch$resetColor"
      }
    } catch {}
  }

  # Construir prompt
  $promptString = "${cwdColor}$leaf${timeColor} at ${time}${resetColor}${gitBranch}"
  $promptString += " $timeColor$arrow$resetColor "

  # Devolver el prompt
  $promptString
}





#Alias

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

function Test-PathExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Path # El par├ímetro que recibir├í la ruta a verificar
  )

  if (Test-Path -Path $Path) { return $true}
  else { return $false }
}


#Touch
Set-Alias to touch

function touch {
  param(
    [Parameter(Mandatory=$true)] # Makes the parameter required
    [string]$dir_file,
    [string]$data
  )

  $final_dir = (Get-Location).Path + $dir_file.Substring(1)
  echo($data) >> $dir_file
}


# Git
function gts { git status }
function gta { git add .}
function gtp { git push }
function gtpl { git pull }

function gtm {
  param([string]$comment)
  if($comment -eq ""){ $comment = "f: menor update" }
  git commit -m $comment
}

function gtl {
  param([int]$index)
  if($index -eq 0){ git log }
  else { git log -$index }
}

function fcm {
  param([string]$comment)
  if($comment -eq ""){ $comment = "f: menor update" }
  gta && gtm $comment && gtp
}


# Nvim
Set-Alias vi nvim


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


# Linux
Set-Alias lnx  wsl.exe
function lnh { wsl.exe --cd "~" }


# Go

## Go Run
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
Set-Alias tre tree

# Surreal
Set-Alias sr surreal.exe


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

#Apache Server StoP
function assp { httpd -k stop }
#Apache Server StarT
function asst { httpd -k start }
#Apache Server ReStart
function asrs { httpd -k restart }



## System
function dd { shutdown /s /t 0 }
function .. { Set-Location .. }
function ee { exit }
function ex {
  param([string]$Path)
  if($Path -eq ""){$Path = Get-Location}
  explorer $Path
}
Set-Alias cls clear
Set-Alias mk mkdir

# Paths
function nvc { cd $env:LOCALAPPDATA\nvim }
function alc { cd $env:APPDATA\alacritty}
function ldd { cd $env:LOCALAPPDATA\}
function gg { cd D:/Github/ }
function hh { cd E:/carlo/ }



function cbf{
  param (
    [Parameter(Mandatory=$true)] # Makes the parameter required
    [string]$FilePath            # Parameter of type string
  )
  bat $FilePath | scb
}

##Zip & Unzip
function unzip {
  [Parameter(Mandatory=$true)]
  [string]$Filepath
  [string]$DesPath
  Expand-Archive -LiteralPath $FilePath -DestinationPath $Despath
}


function zip {
  param (
    [Parameter(Mandatory = $true)]
    [string]$Oripath,

    [Parameter(Mandatory = $true)]
    [string]$DesPath
  )

  if ($Oripath -eq "./*" -or $Oripath -eq "*") {
    $Oripath = (Get-Location).Path + "\\*"
  }

  if ($DesPath -eq "./../" -or $DesPath -eq "../") {
    $oldPath = Get-Location
    Set-Location "../"
    $DesPath = (Get-Location).Path + "\fzip.zip"
    Set-Location $oldPath
    $oldPath = Get-Location
  }
  if ($DesPath -eq "." -or $Despath -eq "./") {
    $DesPath = (Get-Location).Path + "\fzip.zip"
  }

  Compress-Archive -Path $Oripath -DestinationPath $DesPath -Force
}


# Custom ls
function la {
  Get-ChildItem | ForEach-Object {
    $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e5ff}" } # folder icon
    $color_code = $PSStyle.Foreground.FromRgb(210,210,210)

    if ($_.PSIsContainer) {
      $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e5ff}" } # folder icon
      $color_code = $PSStyle.Foreground.FromRgb(210,210,210)
    } else {
      switch -regex ($_.Extension.ToLower()) {
        "\.(png|jpg|jpeg|webp|gif)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{f03e}" }
          $color_code = $PSStyle.Foreground.FromRgb(246, 95, 156)
        }  # images
        "\.(mkv|mp4|mov|avi|webm|flv)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{f03d}" }
          $color_code = $PSStyle.Foreground.FromRgb(147,145, 195)
        }  # videos
        "\.(ogg|wav|mp3|m4a|flac|aac|aiff)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{f001}" }
          $color_code = $PSStyle.Foreground.FromRgb(178, 168, 255)
        } # Audio files
        "\.(zip|rar|7z)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{f410}" }
          $color_code = $PSStyle.Foreground.FromRgb(239, 234, 95)
        }   # zips


        "\.(ps1|bat|sh)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e795}" }
          $color_code = $PSStyle.Foreground.FromRgb(77, 201, 77)
        }    # shell/script
        "\.(md)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{039B}" }
          $color_code = $PSStyle.Foreground.FromRgb(255, 255, 255)
        } # markdown
        "\.(cpp|h)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e61d}" }
          $color_code = $PSStyle.Foreground.FromRgb(66, 197, 233)
        } # cpp
        "\.(rs|toml)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e7a8}" }
          $color_code = $PSStyle.Foreground.FromRgb(244, 80, 111)
        } # rust
        "\.(cs|csproj|sln)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e7b2}" }
          $color_code = $PSStyle.Foreground.FromRgb(144, 131, 242)
        } # csharp
        "\.(go|mod|sum)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e627}" }
          $color_code = $PSStyle.Foreground.FromRgb(110, 191, 252)
        } # golang
        "\.(gitignore|gitattributes)$" {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e702}" }
          $color_code = $PSStyle.Foreground.FromRgb(244, 80, 111)
        } # git
        "\.(js|jsx|json)$"{
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{ed0d}" }
          $color_code = $PSStyle.Foreground.FromRgb(229, 192, 123)
        }# javascript

        default {
          $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{f0f6}" }; $color_code = $PSStyle.Foreground.FromRgb(163,163,163)}# generic file
      }
    }
    Write-Host "$color_code$icon  $($_.Name)"
  }
}



clear
