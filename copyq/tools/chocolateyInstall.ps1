$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$url32       = 'https://github.com/hluk/CopyQ/releases/download/v2.7.1/copyq-2.7.1-setup.exe'
$checksum32  = '781787EF7DB6801A843DED62900380CCCF31A0E9917FA13A55B19932A8F35DAC'
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
