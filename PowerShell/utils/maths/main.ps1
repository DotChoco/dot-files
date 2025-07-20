#Variables
$MATHDIR = "$UTILSDIR/maths"




##Set scale
function scale{
  param([object[]]$Scale)
  return [Math]::Round([double]$Scale[0], [int]$Scale[1])
}

##Set scale
function scl{
  param([object[]]$Scale)
  $Result = scale $Scale
  echo $Result
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


#Imports
. "$MATHDIR/taxes.ps1"


