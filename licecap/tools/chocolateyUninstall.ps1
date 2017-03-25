$ErrorActionPreference = 'Stop'

$packageName = 'licecap'

$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }

$uninstall_path = "$installLocation\Uninstall.exe"
if (!(Test-Path $uninstall_path)) { Write-Host "Can't find uninstaller, software uninstall by other means"; return }
& $uninstall_path /S
