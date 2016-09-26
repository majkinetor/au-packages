$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.7.5/dbeaver-ee-3.7.5-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.7.5/dbeaver-ee-3.7.5-x86_64-setup.exe'
$checksum32  = '2c5e5b379fed7bb023753b39a3c8b38e27621fb82f606cf7453ab75cc33310d3'
$checksum64  = '8951c4da1c41227ec8135f8aea888314f09c72db2fa0b384b9a8061acbbb4d53'


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
