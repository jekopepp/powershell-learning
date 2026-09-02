# Oggetti, moduli e PowerShell ISE

Appunti della sessione del 2 settembre 2026.

## L'idea chiave: PowerShell lavora con oggetti

In PowerShell i comandi, chiamati **cmdlet**, restituiscono spesso degli oggetti con proprietà e metodi; non producono soltanto testo da leggere sullo schermo.

La pipeline (`|`) passa gli oggetti da un comando al successivo. Per esempio:

```powershell
Get-Date | Select-Object DateTime, DayOfWeek
```

`Get-Date` produce un oggetto data/ora, mentre `Select-Object` ne mostra solo le proprietà `DateTime` e `DayOfWeek`.

Per vedere cosa contiene un oggetto:

```powershell
Get-Date | Get-Member
```

## Informazioni sul sistema

```powershell
Get-TimeZone
Get-Date
Get-NetConnectionProfile
```

- `Get-TimeZone` mostra il fuso orario configurato. Nella sessione: `W. Europe Standard Time`, che include Roma.
- `Get-Date` restituisce data e ora locali con molte proprietà.
- `Get-NetConnectionProfile` mostra il profilo della rete. La rete Ethernet era connessa a Internet e classificata come `Public`.

> Il profilo `Public` è più restrittivo di `Private`. Va modificato solo conoscendo bene il tipo di rete a cui si è connessi.

Esempi pratici:

```powershell
Get-Date -Format 'dd/MM/yyyy HH:mm'
Get-NetConnectionProfile | Select-Object Name, NetworkCategory, IPv4Connectivity
```

## Moduli

Un **modulo** è un pacchetto che raccoglie cmdlet, funzioni e risorse dedicate a un argomento, ad esempio rete, archivi o sicurezza.

```powershell
# Moduli disponibili sul disco
Get-Module -ListAvailable

# Moduli caricati nella sessione corrente
Get-Module

# Caricare un modulo nella sessione
Import-Module AppLocker

# Vedere i comandi forniti da un modulo
Get-Command -Module AppLocker
```

La distinzione da ricordare è:

| Situazione | Comando |
| --- | --- |
| Il modulo è installato e può essere usato | `Get-Module -ListAvailable` |
| Il modulo è già in memoria nella sessione | `Get-Module` |
| Il modulo viene caricato manualmente | `Import-Module NomeModulo` |
| Voglio conoscere i comandi di un modulo | `Get-Command -Module NomeModulo` |

### Dove vengono cercati i moduli

Per vedere tutte le cartelle cercate dalla sessione attuale:

```powershell
$env:PSModulePath -split [IO.Path]::PathSeparator
```

Nella sessione sono comparsi, tra gli altri, questi percorsi di Windows PowerShell:

```text
C:\Program Files\WindowsPowerShell\Modules
C:\Program Files (x86)\WindowsPowerShell\Modules
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules
```

I percorsi effettivi possono cambiare in base alla versione di PowerShell e all'utente con cui si apre la console.

## AppLocker: lo switch `-Local`

Il cmdlet `Get-AppLockerPolicy` richiede di indicare quale policy leggere. `-Local` è uno **switch**, quindi si usa senza assegnargli un valore:

```powershell
Get-AppLockerPolicy -Local
```

Scrivere `-Local c` produce un errore perché `c` non può essere convertito nello switch. Il comando può richiedere privilegi amministrativi; inoltre, se AppLocker non è configurato, potrebbe non esserci una policy utile da visualizzare.

## PowerShell 7, Windows PowerShell e ISE

L'output della sessione mostrava moduli di **Windows PowerShell 5.1**, incluso il modulo `ISE`.

- **Windows PowerShell 5.1** è incluso in Windows e si avvia normalmente con `powershell.exe`.
- **PowerShell 7** è la versione moderna e multipiattaforma; si avvia con `pwsh`.
- **PowerShell ISE** è l'editor storico di Windows PowerShell 5.1 e non supporta in modo nativo completo PowerShell 7.

Per identificare la shell in uso:

```powershell
$PSVersionTable
```

Per avviare PowerShell 7 da una console:

```powershell
pwsh
```

## Comandi da riprendere

```powershell
Get-Help Get-Module -Examples
Get-Command *service*
Get-Date | Get-Member
Get-Module -ListAvailable | Sort-Object Name
```

