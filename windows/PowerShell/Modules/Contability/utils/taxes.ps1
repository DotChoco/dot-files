#Calculate the IEPS (Sin Impuestos)
function pps{
  param([object[]]$Data)

  #UNIT PRICE
  $UP = [double]$Data[0]

  $IEPS = [double]$Data[1]
  $TAX = [double]$Data[2]

  #UNIT PRICE IEPS
  $UPI = $UP * $IEPS

  #UNIT PRICE TAX
  $UPTAX = ($UPI + $UP) * $TAX

  #RESULTS
  [double]$TRANSFERS = $UPI + $UPTAX
  [double]$TOTAL = $UP + $TRANSFERS

  $RESULT = scale $TOTAL,6

  Write-Host("Total: " + $RESULT)
  Write-Host("Traslados: " + $TRANSFERS)

}

#Calculate the IEPS (NETO)
function ppn{
  param([object[]]$Data)

  #UNIT PRICE
  $UP = [double]$Data[0]

  $IEPS = [double]$Data[1]
  $TAX = [double]$Data[2]

  $MAX_PORCENT = 100
  $TAX_PORCENT = $TAX * $MAX_PORCENT
  $IEPS_PORCENT = $IEPS * $MAX_PORCENT

  #UNIT PRICE TAX
  $TAX_MAX_PORCENT = $MAX_PORCENT + $TAX_PORCENT
  [double]$UPTAX = ($TAX_PORCENT * $UP) / $TAX_MAX_PORCENT


  #UNIT PRICE IEPS
  $IEPS_MAX_PORCENT = $MAX_PORCENT + $IEPS_PORCENT

  [double]$UPIEPS_SUBSTRACT = $UP - $UPTAX
  [double]$UPI = ($IEPS_PORCENT * $UPIEPS_SUBSTRACT) / $IEPS_MAX_PORCENT


  #RESULTS
  [double]$TRANSFERS = $UPI + $UPTAX
  [double]$TOTAL = $UP - $TRANSFERS

  $RES_TOTAL = scale $TOTAL,6
  $RES_TRANSFERS = scale $TRANSFERS,6

  Write-Host("Total: " + $RES_TOTAL)
  Write-Host("Traslados: " + $RES_TRANSFERS)

}


## Calculate the ISR from(FA Nomina)
function CalculateISR{
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

  $data = Import-Csv -Path "$PWSDIR/Modules/Maths/docs/isr_$file" -Delimiter ','

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


# Usage
function isr{
  while ($true) {
    $salario = Read-Host "Introduce el sueldo diario"
    $peri = Read-Host "Introduce la periodicidad"
    $isr = CalculateISR -SueldoDiario $salario -Periodicidad $peri
    Write-Host "El ISR diario es: $isr"
    $salario = Read-Host "Presiona cualquier tecla para calcular de nuevo"
  }
}

