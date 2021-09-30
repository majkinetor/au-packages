$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

Set-AutoUpdate -Enable

$packageArgs = @{
  packageName            = 'signal'
  fileType               = 'EXE'
  url                    = 'https://updates.signal.org/desktop/signal-desktop-win-5.18.0.exe'
  checksum               = '6290fe3e5d36b40f0efeb67e748bda01f3934e31a4f14cfad0a9e323262a8f7d'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Signal *'
}
Install-ChocolateyPackage @packageArgs

Install-DesktopShortcut
Set-SignalOptions

Register-Application "$toolsPath\signal.bat" signal
Write-Host "Application registered as signal"

if ($pp.NoAutoUpdate) { Write-Host "Disabling auto update";  Set-AutoUpdate -Disable }
