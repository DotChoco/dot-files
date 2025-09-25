
##Set scale
function scale{
  param([object[]]$Scale)
  $value = [double]$Scale[0]
  $decimals = [int]$Scale[1] # Number of decimal places you want

  # Build the format string dynamically based on $decimals
  $formatString = "{0:F$decimals}"

  # Format the value with the specified number of decimal places
  $formattedValue = $formatString -f $value

  return $formattedValue
}


##Round
function roundn{
  param([object[]]$Scale)
  return [Math]::Round([double]$Scale[0], [int]$Scale[1])
}


##Pow any value
function pow {
  param([object[]]$Values)
  [double]$base = $Values[0]
  [double]$exp = $Values[1]

  [Math]::Pow($base, $exp)
}

#Greater Than
function gt {
  param([object[]]$Values)
  [double]$Value_Greater = $Values[0]
  [double]$Comparer = $Values[1]

  if($Value_Greater -gt $Comparer){ echo("True") }
  else{ echo("False") }
}


function Module_N {
  param([object[]]$Values)
  $mod = [float]$Values[0]
  $n = [float]$Values[1]
  return $n%$mod
}








#Alias
Set-Alias scl scale
Set-Alias mod Module_N


