$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/5.1.0/dbeaver-ee-5.1.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/5.1.0/dbeaver-ee-5.1.0-x86_64-setup.exe'
$checksum32  = '9a7e2855dc9cf9e2793edc42bac66f13e150d59431a29aed8fa3419d5dd3ad4c'
$checksum64  = '0531e0dd952eb893808a3ff84219c2b594b6159081e122b4aa503292b3fca509'

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
