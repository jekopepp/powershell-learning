<#
.SYNOPSIS
    Esplora informazioni del sistema e i moduli PowerShell disponibili.

.DESCRIPTION
    Esercizio sui cmdlet, gli oggetti e la pipeline.
    Non modifica alcuna impostazione del computer.
#>

function Show-Section {
    param([string]$Title)

    Write-Host "`n=== $Title ===" -ForegroundColor Cyan
}

Show-Section 'Data e fuso orario'
Get-TimeZone | Select-Object Id, DisplayName, BaseUtcOffset
Get-Date -Format 'dddd dd/MM/yyyy HH:mm'

Show-Section 'Profilo di rete'
Get-NetConnectionProfile |
    Select-Object Name, InterfaceAlias, NetworkCategory, IPv4Connectivity, IPv6Connectivity

Show-Section 'Versione di PowerShell'
$PSVersionTable | Select-Object PSVersion, PSEdition, OS

Show-Section 'Percorsi in cui PowerShell cerca i moduli'
$env:PSModulePath -split [IO.Path]::PathSeparator

Show-Section 'Moduli caricati nella sessione'
Get-Module | Sort-Object Name | Select-Object Name, Version, ModuleType

Show-Section 'Moduli disponibili sul computer'
Get-Module -ListAvailable |
    Sort-Object Name |
    Select-Object Name, Version, ModuleType, Path

Show-Section 'Comandi del modulo AppLocker (se disponibile)'
Get-Command -Module AppLocker -ErrorAction SilentlyContinue |
    Select-Object CommandType, Name, Version

<#
Per provare AppLocker, prima carica il modulo:

    Import-Module AppLocker
    Get-Command -Module AppLocker

La policy locale, se configurata, si legge con:

    Get-AppLockerPolicy -Local

Il comando può richiedere l'esecuzione di PowerShell come amministratore.
#>

