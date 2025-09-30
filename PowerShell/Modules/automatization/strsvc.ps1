function Initialize_STomcat
{
  param ([string]$serviceName)

  $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
  if (-not $service)
  {
    Write-Output "El servicio '$serviceName' no existe."
    return
  }

  if ($service.Status -ne 'Running')
  {
    Write-Output "Iniciando el servicio '$serviceName'..."
    try
    {
      Start-Service -Name $serviceName
    } catch
    {
      Write-Output "Error al intentar iniciar el servicio: $_"
      return
    }
  } else
  {
    Write-Output "El servicio ya está corriendo."
  }

  # Waiting
  $dots = 0
  $maxDots = 3
  while ($true)
  {
    $service.Refresh()

    if ($service.Status -eq 'Running')
    {
      Write-Host "`rEstado actual: $($service.Status) ✅ Servicio iniciado correctamente." -NoNewline
      break
    } else
    {
      $dotsString = "." * $dots
      $spaces = " " * ($maxDots - $dots)
      Write-Host "`rEsperando$dotsString$spaces" -NoNewline

      # Animación de puntos
      $dots++
      if ($dots -gt $maxDots)
      { $dots = 0
      }

      Start-Sleep -Milliseconds 500
    }
  }

  Write-Output "`nEl proceso de iniciar el servicio '$serviceName' se completó exitosamente."

}
