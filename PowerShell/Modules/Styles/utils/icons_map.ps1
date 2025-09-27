# Map
$iconMap = & {
  # Variables
  $img= [pscustomobject]@{ Icon="`u{f03e}"; Color=$PSStyle.Foreground.FromRgb(246,95,156) }
  $video= [pscustomobject]@{ Icon="`u{f03d}"; Color=$PSStyle.Foreground.FromRgb(147,145, 195) }
  $audio= [pscustomobject]@{ Icon="`u{f001}"; Color=$PSStyle.Foreground.FromRgb(178,168, 255) }
  $zip= [pscustomobject]@{ Icon="`u{f410}"; Color=$PSStyle.Foreground.FromRgb(239, 234, 95) }
  $md= [pscustomobject]@{ Icon="`u{039B}"; Color=$PSStyle.Foreground.FromRgb(255, 255, 255) }
  $shell= [pscustomobject]@{ Icon="`u{e795}"; Color=$PSStyle.Foreground.FromRgb(77, 201, 77) }
  $excel= [pscustomobject]@{ Icon="`u{f1c3}"; Color=$PSStyle.Foreground.FromRgb(140, 255, 140) }
  $pdf= [pscustomobject]@{ Icon="`u{f1c1}"; Color=$PSStyle.Foreground.FromRgb(255, 80, 80) }
  $folder= [pscustomobject]@{ Icon="`u{e5ff}"; Color=$PSStyle.Foreground.FromRgb(210,210,210) }
  $giticon= [pscustomobject]@{ Icon="`u{e702}"; Color=$PSStyle.Foreground.FromRgb(245, 0, 0) }
  $jsx= [pscustomobject]@{ Icon="`u{ed0d}"; Color=$PSStyle.Foreground.FromRgb(229, 192, 123) }
  $docx= [pscustomobject]@{ Icon="`u{f1c2}"; Color=$PSStyle.Foreground.FromRgb(107, 164, 255) }
  $bins= [pscustomobject]@{ Icon="`u{f471}"; Color=$PSStyle.Foreground.FromRgb(255, 70, 135) }
  $lua= [pscustomobject]@{ Icon="`u{e620}"; Color=$PSStyle.Foreground.FromRgb(110, 119, 250) }
  $golang= [pscustomobject]@{ Icon="`u{e627}"; Color=$PSStyle.Foreground.FromRgb(110, 191, 252) }
  $csharp= [pscustomobject]@{ Icon="`u{e7b2}"; Color=$PSStyle.Foreground.FromRgb(162, 131, 242) }
  $cpp= [pscustomobject]@{ Icon="`u{e61d}"; Color=$PSStyle.Foreground.FromRgb(131, 140, 242) }
  $rust= [pscustomobject]@{ Icon="`u{e7a8}"; Color=$PSStyle.Foreground.FromRgb(244, 80, 111) }

  # KeyValues
  @{
    # images
    ".png" = $img
    ".jpg" = $img
    ".jpeg" = $img
    ".webp" = $img
    ".gif" = $img

    # videos
    ".mkv" = $video
    ".mp4" = $video
    ".mov" = $video
    ".avi" = $video
    ".webm" = $video
    ".flv" = $video

    # Audio files
    ".ogg" = $audio
    ".wav" = $audio
    ".mp3" = $audio
    ".m4a" = $audio
    ".flac" = $audio
    ".aac" = $audio
    ".aiff" = $audio

    # zips
    ".zip" = $zip
    ".rar" = $zip
    ".7z" = $zip

    # Executables
    ".exe" = $bins
    ".msi" = $bins

    #pdf's
    ".pdf" = $pdf

    # word files
    ".doc" = $docx
    ".docx" = $docx

    # excel's
    ".xls" = $excel
    ".xlsx" = $excel
    ".xml" = $excel
    ".csv" = $excel

    # shell/script
    ".ps1" = $shell
    ".bat" = $shell
    ".sh" = $shell

    # markdown
    ".md" = $md

    # git
    ".gitignore" = $giticon
    ".gitattributes" = $giticon

    # javascript
    ".js" = $jsx
    ".jsx" = $jsx
    ".json" = $jsx

    # lua
    ".lua" = $lua

    # cpp
    ".cpp" = $cpp
    ".h" = $cpp

    # rust
    ".rs" = $rust
    ".toml" = $rust

    # csharp
    ".cs" = $csharp
    ".csproj" = $csharp
    ".sln" = $csharp

    # golang
    ".go" = $golang
    ".mod" = $golang
    ".sum" = $golang

  }
}
