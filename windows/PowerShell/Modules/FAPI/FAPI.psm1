# FAPI/FAPI.psm1

# Private Variable (doesn't export)
$BasePath = $PSScriptRoot

# Dot‑source all subfolders
Get-ChildItem -Path $BasePath -Recurse -Filter '*.ps1' -File | ForEach-Object {
    . $_.FullName
}

# Export ALL (You can filter from Function, Alias, Variable, Cmdlet)
Export-ModuleMember -Function * -Alias * -Variable *


