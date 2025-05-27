#(@(& 'C:/Users/carlo/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\carlo\AppData\Local\Programs\oh-my-posh\themes\dracula.omp.json' --print) -join "`n") | Invoke-Expression
Import-Module Terminal-Icons
Set-PSReadLineOption -PredictionViewStyle ListView


# Powerline
function prompt {
  $cwd = Split-Path (Get-Location) -Leaf
  $time = Get-Date -Format "HH:mm"
  $arrow = "`e[38;5;10mΓ¥»`e[0m"

  $gitBranch = ""
  if (Get-Command git -ErrorAction SilentlyContinue) {
    try {
      $branchName = git rev-parse --abbrev-ref HEAD 2>$null
      if ($branchName) {
          $gitBranch = "`e[38;5;13mεéá $branchName`e[0m"
      }
    } catch {}
  }

  Write-Host "`e[38;5;11m$cwd`e[38;5;10m at $time`e[0m $gitBranch" -NoNewline
  return " $arrow "
}



# custom ls
function lsi {
    Get-ChildItem | ForEach-Object {
        $icon = ""
        $color_code = $PSStyle.Foreground.FromRgb(200,200,200)

        if ($_.PSIsContainer) {
            $icon = "εù┐"  # folder icon
            $color_code = $PSStyle.Foreground.FromRgb(200,200,200)
            # $color_code = $PSStyle.Foreground.FromRgb(0, 178, 178)
        } else {
            switch -regex ($_.Extension.ToLower()) {
                "\.(ps1|bat|sh)$" {
                  $icon = "ε₧ò";
                  $color = "Green"
                  $color_code = $PSStyle.Foreground.FromRgb(77, 201, 77)
                }    # shell/script

                "\.(txt)$" {
                  $icon = "∩à£";
                  $color_code = $PSStyle.Foreground.FromRgb(255, 255, 255)
                }    # text

                "\.(md)$" {
                  $icon = "≤░ìö";
                  $color_code = $PSStyle.Foreground.FromRgb(255, 255, 255)
                } # markdown

                "\.(png|jpg|jpeg)$" {
                  $icon = "εëä";
                  $color_code = $PSStyle.Foreground.FromRgb(246, 95, 156)
                  $color = "Magenta"
                }  # images

                "\.(zip|rar|7z)$" {
                  $icon = "∩ÉÉ";
                  $color_code = $PSStyle.Foreground.FromRgb(239, 234, 95)
                }   # archive

                "\.(cpp|h)$" {
                  $icon = "εÿ¥";
                  $color_code = $PSStyle.Foreground.FromRgb(66, 197, 233)
                } # code files

                "\.(rs|mod)$" {
                  $icon = "ε₧¿";
                  $color_code = $PSStyle.Foreground.FromRgb(244, 80, 111)
                } # code files

                "\.(cs|csproj|sln)$" {
                  $icon = "ε₧▓"
                  $color_code = $PSStyle.Foreground.FromRgb(173, 108, 217)
                } # code files

                "\.(go)$" {
                  $icon = "εÿº";
                  $color_code = $PSStyle.Foreground.FromRgb(110, 191, 252)
                } # code files

                default { $icon = "∩â╢"; $color_code = $PSStyle.Foreground.FromRgb(183,183,183)}                # generic file
            }
        }

        Write-Host "$color_code$icon  $($_.Name)"
        # Write-Host "$colorCode$icon  $(<span class="math-inline">\_\.Name\)</span>($PSStyle.Reset)"
    }
}





#Alias


# Cmake
function cmk{
  param(
    [string]$dir_file
  )
  if($dir_file -eq ""){
    $dir_file = (Get-Location).Path + "\CMakeLists.txt"
  }
  # echo($dir_file)
  cmake $dir_file
}

function cmm {
  $dir_build= (Get-Location).Path + "\build\"
  $exist_dir = Test-PathExists $dir_build

  if($exist_dir -eq $true){ rm $dir_build -Force -Recurse }

  mkdir $dir_build
  cd build/

  $dir_build= (Get-Location).Path + "\..\CMakeLists.txt"
  cmk $dir_build

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
function to {
  param(
    [Parameter(Mandatory=$true)] # Makes the parameter required
    [string]$dir_file,
    [string]$data
  )

  # echo($data)
  # echo($final_dir)
  touch $dir_file $data
}

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
function gtm {
  param([string]$comment)
  git commit -m $comment
}

function gtl {
  [Parameter(Mandatory=$true)] # Makes the parameter required
  param([int]$index)
  if($index -eq 0){ git log }
  else { git log -$index }
}



# Nvim
Set-Alias vi nvim

# Paths
function nvc { cd $env:LOCALAPPDATA\nvim }
function gg { cd D:/Github/ }
function hh { cd E:/carlo/ }

# SPOT
function spd {
    param (
        [string]$data
    )
    python.exe -m spotdl download $data
}

#CPP
function cr {
    param (
        [string]$path,
        [string]$name
    )
    g++.exe -o $path $name
}

function crb {
    param (
        [string]$OutputName = "program",
        [string]$ProjectRoot = "."
    )
    g++.exe -o $OutputName $ProjectRoot\src\main.cpp
}


# Linux
function lnx { wsl.exe }
function lnh { wsl.exe --cd "~" }


# Go

## Go Run
function gor {
    param (
        [string]$path
    )
    go.exe run $path
}



# Eza
function tree {
    param (
        [string]$path
    )
    if($path -eq ""){ $path="."}
    eza -T $path
}
function tre{
  param ([string]$path)
  tree $path
}


# Surreal
function sr { surreal.exe }


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

function dnrr { dotnet build -c Release }
function dnb { dotnet build }
function dnr { dotnet run }


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
function cls { clear }
function ee { exit }
function dd { shutdown /s /t 0 }
function .. { Set-Location .. }
function ex { explorer . }
function mk {
    param([string]$folderName)
    mkdir $folderName
}

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

    echo("Despath")
    echo($DesPath)
    Compress-Archive -Path $Oripath -DestinationPath $DesPath -Force
}

clear
