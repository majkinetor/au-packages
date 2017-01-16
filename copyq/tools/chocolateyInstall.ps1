$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$running     = if (ps $packageName -ea 0) { $true } else { $false }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://github.com/hluk/CopyQ/releases/download/v2.8.2/copyq-v2.8.2-setup.exe'
  checksum       = '3b188645530ce6263150b280dfabcdca2591de105cebcc16db289f2695c83c53'
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
