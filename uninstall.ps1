$json = Get-Content -Path "$env:LOCALAPPDATA/Powershell/conf.json" -Raw | ConvertFrom-Json

# Global Mutables Variables
$jhome = $json.homedir
$jdev = $json.devdir
$jpws = $json.pwsdir
$jvi = $json.vidir


Write-Host "`n`n`n`n"
Write-Host "Purgando Datos"

Remove-Item $jdev -Force -Recurse
Remove-Item $jpws -Force -Recurse
Remove-Item $jvi -Force -Recurse
Remove-Item $jhome -Force -Recurse
Remove-Item "$env:LOCALAPPDATA/Powershell/conf.json" -Force -Recurse
Remove-Item "$env:LOCALAPPDATA/nvim-data" -Force -Recurse


Write-Host "`n`n`n`n"
Write-Host "Borrando informacion de Git"
git config --global --unset user.name
git config --global --unset user.email
Remove-Item "$env:USERPROFILE/.gitconfig" -Force -Recurse
Remove-Item "$env:USERPROFILE/.git-credentials" -Force -Recurse
Remove-Item "$env:USERPROFILE/.ssh" -Force -Recurse

Write-Host "`n`n`n`n"
Write-Host "Informacion Actual de Git"
git config --global --list


 # [---------- Restart Windows Terminal ----------]
Write-Host "Purga completada.."
Write-Host "La terminal se reiniciara automaticamente"
Start-Process wt
Stop-Process -Id (Get-Process -Id $PID).Parent.Id
