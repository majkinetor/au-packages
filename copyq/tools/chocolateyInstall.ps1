$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$url32       = 'https://github.com/hluk/CopyQ/releases/download/v2.7.1/copyq-2.7.1-setup.exe'
$checksum32  = '781787ef7db6801a843ded62900380cccf31a0e9917fa13a55b19932a8f35dac'
$running     = if (ps $packageName -ea 0) { $true } else { $false }

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  checksum               = $checksum32
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation) { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

if ($installLocation -and $running) {
    Write-Host "CopyQ was running before update, starting it up again"
    start "$installLocation\copyq.exe"
}
