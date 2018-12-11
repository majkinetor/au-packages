$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/5.3.0/dbeaver-ee-5.3.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/5.3.0/dbeaver-ee-5.3.0-x86_64-setup.exe'
$checksum32  = '540378092c7fb6e3617dd758e27c64ec4f1b08ba20d055943527bfc697cdc1f9'
$checksum64  = 'cb5c2861180bad8cc2d2c1894f10bdf320845a159bf38f80dfc3a8a6d2fedb34'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
