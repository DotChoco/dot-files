function la {
  param([string]$path)
  if($path -eq ""){ $dirs = Get-ChildItem }
  else{ $dirs = Get-ChildItem -Path $path }
  $supportsVT = $Host.UI.SupportsVirtualTerminal
  $icon = $defaultIcon.Icon
  $color = $defaultIcon.Color
  $defaultIcon = [pscustomobject]@{ Icon="`u{f0f6}"; Color=$PSStyle.Foreground.FromRgb(163,163,163) }

  foreach ($it in $dirs) {
    if ($it.PSIsContainer) {
      $icon = if ($Host.UI.SupportsVirtualTerminal) { "`u{e5ff}" } # folder icon
      $color = $PSStyle.Foreground.FromRgb(210,210,210)
    } else {
      $ext = $it.Extension.ToLower()
      $entry = if ($iconMap.ContainsKey($ext)) { $iconMap[$ext] } else { $defaultIcon }
      $icon  = $supportsVT ? $entry.Icon : ""
      $color = $entry.Color
    }

    Write-Host "$color$icon  $($it.Name)"
  }
}

function ll {
  param([string]$path)
  echo("-----------------") && la $path && echo("-----------------")
}
