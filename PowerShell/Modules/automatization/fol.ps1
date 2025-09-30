function Make_Path
{
  param([string]$basePath)
  # Obtener la fecha de hoy en formato YYYY-MM-DD
  $today = Get-Date -Format "yyyyMMdd"

  # Ruta completa
  $newFolder = Join-Path $basePath $today

  # Crear carpeta (si no existe)
  if (-not (Test-Path $newFolder))
  {
    New-Item -Path $newFolder -ItemType Directory | Out-Null
    Write-Output "Carpeta creada: $newFolder"
  } else
  {
    Write-Output "La carpeta ya existe: $newFolder"
  }

}

function Move_JAR
{
  param(
    [string]$Origin,
    [string]$Destination
  )
  $JFile = Get-ChildItem -Path $Origin -Filter "*.jar" | Select-Object -ExpandProperty FullName
  Move-Item $JFile $Destination
}
