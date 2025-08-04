#Calculate the IEPS (Sin Impuestos)
function pps{
  param([object[]]$Data)

  #UNIT PRICE
  $UP = [double]$Data[0]

  $IEPS = [double]$Data[1]
  $TAX = [double]$Data[2]
  $DECIMALS = ([int]$DECIMALS -gt 0) ? [int]$Data[3] : 2

  #UNIT PRICE IEPS
  $UPI = $UP * $IEPS

  #UNIT PRICE TAX
  $UPTAX = ($UPI + $UP) * $TAX

  #RESULTS
  [double]$TRANSFERS = $UPI + $UPTAX
  [double]$TOTAL = $UP + $TRANSFERS

  $RESULT = scale $TOTAL,$DECIMALS

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
  $DECIMALS = ([int]$DECIMALS -gt 0) ? [int]$Data[3] : 2

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

  $RES_TOTAL = scale $TOTAL,$DECIMALS
  $RES_TRANSFERS = scale $TRANSFERS,$DECIMALS

  Write-Host("Total: " + $RES_TOTAL)
  Write-Host("Traslados: " + $RES_TRANSFERS)

}


