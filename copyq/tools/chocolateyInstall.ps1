$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$running     = if (ps $packageName -ea 0) { $true } else { $false }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://github.com/hluk/CopyQ/releases/download/v2.8.1/copyq-v2.8.1-setup.exe'
  checksum       = '24c236bf2cb954a1a944b6a24612badef15621b49a07826b21e8e12c92027806'
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
