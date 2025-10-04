$json = Get-Content -Path "$env:LOCALAPPDATA/Powershell/conf.json" -Raw | ConvertFrom-Json

# Global Mutables Variables
$jpws = $json.pwsdir
$jvi = $json.vidir


Write-Host "`n`n`n`n"
Write-Host "Purgando Datos"

Remove-Item $jvi -Force -Recurse
Remove-Item $jhome -Force -Recurse
Remove-Item "$env:LOCALAPPDATA/Powershell/conf.json" -Force -Recurse
Remove-Item "$env:LOCALAPPDATA/nvim-data" -Force -Recurse


Write-Host "`n`n`n`n"
Write-Host "Borrando informacion de Git"
git config set --global user.name ""
git config set --global user.email ""
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
