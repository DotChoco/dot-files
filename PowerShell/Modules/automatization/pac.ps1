function R_PacProperties
{
  param(
    [string]$file,
    [string]$target,
    [string]$replacement
  )
  $content = Get-Content $file
  $content = $content -replace [Regex]::Escape($target), $replacement
  $content | Set-Content -Encoding UTF8 $file
}
