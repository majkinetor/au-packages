$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$running     = if (ps $packageName -ea 0) { $true } else { $false }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://github.com/hluk/CopyQ/releases/download/v2.8.0/copyq-v2.8.0-setup.exe'
  checksum       = '1a8ce7d2e7e53fc68efc4eeaad90478a47452778ed475474d86337d1c8d1a537'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
  softwareName   = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

if ($installLocation -and $running) {
    Write-Host "CopyQ was running before update, starting it up again"
    start "$installLocation\copyq.exe"
}
