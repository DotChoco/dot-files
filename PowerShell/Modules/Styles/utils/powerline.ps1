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

  #Git Information
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

