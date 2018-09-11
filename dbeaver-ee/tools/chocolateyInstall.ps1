$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/5.2.0/dbeaver-ee-5.2.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/5.2.0/dbeaver-ee-5.2.0-x86_64-setup.exe'
$checksum32  = '71ee94e56b5dd82dc0f678478426607af6ecebada2d095881d6fb14968e29825'
$checksum64  = '60fdfe68de393316cac1ace641f3ea20df3e3d220267dbddf3e13bb1850ee47d'

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
