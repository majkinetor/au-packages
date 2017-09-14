$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/4.2.0/dbeaver-ee-4.2.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/4.2.0/dbeaver-ee-4.2.0-x86_64-setup.exe'
$checksum32  = 'a41b044b65d990a797949bb4c9f45c29a811bd62825ebb7d8af639fd63565b7c'
$checksum64  = 'a7151064d2be5810a6437b682fd9fc0a953a41f11de2ec7d20bd40d47e81ac88'

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
