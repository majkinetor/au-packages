$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

Set-AutoUpdate -Enable

$packageArgs = @{
  packageName            = 'signal'
  fileType               = 'EXE'
  url                    = 'https://updates.signal.org/desktop/signal-desktop-win-7.13.0.exe'
  checksum               = '33bc15b97bab08805e845ec108723a892c679430b47badc3b27989ff597075df'
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
