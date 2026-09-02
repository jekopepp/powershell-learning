# Esercizio 01 - Informazioni sul PC

Write-Host "Utente corrente: $env:USERNAME"
Write-Host "Nome del computer: $env:COMPUTERNAME"
Write-Host "Versione PowerShell: $($PSVersionTable.PSVersion)"
Write-Host "Cartella corrente: $(Get-Location)"