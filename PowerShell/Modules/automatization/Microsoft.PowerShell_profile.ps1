#Variables
##Paths
$PacProp = "" #Tomacat Path
$JarPath = "C:\Tomcat 7.0\webapps\ROOT\WEB-INF\lib" #Jar Path
$ZPath   = "C:\Tomcat 7.0\webapps\ROOT" #Zip Path
$FPath   = "C:\Users\Administrator\Documents\updates" #Files Path
$CPath   = $PSScriptRoot #Current Path

$script:NFPath  = "" # NO MODIFICAR ESTA VARIABLE!!

# Service Name
$SVC = "Tomcat9"

# Sources
. "$CPath/strsvc.ps1"
. "$CPath/stpsvc.ps1"
. "$CPath/fol.ps1"
. "$CPath/pac.ps1"
. "$CPath/unz.ps1"


# Crear Carpeta
function Make_Today
{
  param([string]$Path)
  $response = Make_Path -basePath $Path
  if($response -ne "null"){ $script:NFPath = $response }
}


function Update_Prod
{
  # Modificar pac.properties
  R_PacProperties -file $PacProp -target "SMARTER_WEB" -replacement "X"

  # Detener Tomcat
  Stop_STomcat -serviceName $SVC

  # Borrar FactureApp
  Remove-Item "$ZPath/FactureApp" -Force -Recurse

  # Unzip Fichero
  UZCompilation -Origin $FPath -Destination $ZPath

  # Move JAR
  Move_JAR -Origin $FPath -Destination $JarPath

  # Modificar pac.properties
  R_PacProperties -file $PacProp -target "X" -replacement "SMARTER_WEB"

  # Iniciar Tomcat
  Initialize_STomcat -serviceName $SVC

  Write-Host "`n`nUpdate a productivo completo"
}

