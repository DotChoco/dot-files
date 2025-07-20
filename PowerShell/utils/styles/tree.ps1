function Tree-La {
    [CmdletBinding()]
    param(
        [string]$Path    = ".",
        [int]   $Depth   = [int]::MaxValue,
        [int]   $Level   = 0
    )

    # 1) Lista el contenido de esta carpeta con tu función personalizada
    " " * ($Level * 2) + "+-- $Path"
    Push-Location $Path
    la                       # <-- aquí llamas a tu 'la'
    Pop-Location

    # 2) Si no hemos alcanzado la profundidad, entra en subcarpetas
    if ($Level -lt $Depth) {
        Get-ChildItem -Directory | ForEach-Object {
            # recorre cada subcarpeta
            Tree-La -Path $_.FullName -Depth $Depth -Level ($Level + 1)
        }
    }
}

Set-Alias tree Tree-La
