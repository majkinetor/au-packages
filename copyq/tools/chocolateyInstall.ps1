$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$running     = if (ps $packageName -ea 0) { $true } else { $false }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://github.com/hluk/CopyQ/releases/download/v2.9.0/copyq-v2.9.0-setup.exe'
  checksum       = '56f3e783de34e411e6ec010e2e6c03b4ad1adc1fbf5d7f25ffc6f335fee6dd70'
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
