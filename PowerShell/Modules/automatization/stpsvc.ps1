function Stop_STomcat {
  param ([string]$serviceName)
  
  $serviceName = "Tomcat9"
  $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

  if (-not $service)
  {
    Write-Output "El servicio '$serviceName' no existe."
    return
  }

  if ($service.Status -ne 'Stopped')
  {
    Write-Output "Deteniendo el servicio '$serviceName'..."
    try
    {
      Stop-Service -Name $serviceName -Force
    } catch
    {
      Write-Output "Error al intentar detener el servicio: $_"
      return
    }
  } else
  {
    Write-Output "El servicio ya está detenido."
  }

  # Waiting
  $dots = 0
  $maxDots = 3
  while ($true)
  {
    $service.Refresh()

    if ($service.Status -eq 'Stopped')
    {
      Write-Host "`rEstado actual: $($service.Status) ✅ Servicio detenido completamente." -NoNewline
      break
    } else
    {
      $dotsString = "." * $dots
      $spaces = " " * ($maxDots - $dots)
      Write-Host "`rEsperando$dotsString$spaces" -NoNewline

      $dots++
      if ($dots -gt $maxDots)
      { $dots = 0
      }

      Start-Sleep -Milliseconds 500
    }
  }

  Write-Output "`nEl proceso de detener el servicio '$serviceName' se completó exitosamente."

}