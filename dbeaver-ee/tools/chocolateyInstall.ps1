$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/4.2.0/dbeaver-ee-4.2.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/4.2.0/dbeaver-ee-4.2.0-x86_64-setup.exe'
$checksum32  = '44ee0097c6841422f4e17185078f90be2fb9e37394266d21406447a5f82ba33a'
$checksum64  = '45187bd358441fea341a6b5ae2baa35a2e84f0574efd6633e5e66bf5dc8628db'

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
