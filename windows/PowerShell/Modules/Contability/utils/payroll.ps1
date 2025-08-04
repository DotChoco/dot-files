function Aguinaldo{
  param([object[]]$Data)
  $SBD = [double]$Data[0]
  $DA = if($DA -eq 0){ 15 } else{ [double]$Data[1] }
  $DL = [double]$Data[2]

  if($DL -lt 365) { return scale ($SBD * $DA * ($DL/365)),2 }
  else { return scale ($SBD * $DA),2 }
}



## Calculate the ISR from(FA Nomina)
function ISR{
  param (
    [decimal]$SueldoDiario,
    [int]$Periodicidad=0
  )
  $file = "dia.csv"
  if ($Periodicidad -eq 1){$file = "bim.csv"}
  if ($Periodicidad -eq 2){$file = "cato.csv"}
  if ($Periodicidad -eq 3){$file = "dece.csv"}
  if ($Periodicidad -eq 4){$file = "men.csv"}
  if ($Periodicidad -eq 5){$file = "quin.csv"}
  if ($Periodicidad -eq 6){$file = "sem.csv"}

  $data = Import-Csv -Path "$PWSDIR/Modules/Contability/docs/isr_$file" -Delimiter ','

  foreach ($row in $data) {
    # Convert the fields to decimal values
    [decimal]$limInf = $row.'Límite Inferior'
    [decimal]$limSup = $row.'Límite Superior'
    [decimal]$cuota  = $row.'Cuota Fija'
    [decimal]$perc   = $row.'% Excedente'

    if ($SueldoDiario -ge $limInf -and $SueldoDiario -le $limSup) {
      $excedente = $SueldoDiario - $limInf
      $impuesto = $cuota + ($excedente * ($perc / 100))
      # Write-Host "$excedente , $impuesto"
      # Write-Host "$limInf–$limSup : cuota $cuota, % $perc"
      return (scale $impuesto,2)
    }

  }

}

