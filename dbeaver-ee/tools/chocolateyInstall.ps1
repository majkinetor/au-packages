$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/5.2.2/dbeaver-ee-5.2.2-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/5.2.2/dbeaver-ee-5.2.2-x86_64-setup.exe'
$checksum32  = 'd892acbaf03d2d160ffb49972185b7450f818f22a9abe69c62f14f409172e431'
$checksum64  = '1bb1cfa3d7097028f4f98bedc3115e893ad5b527e2ca07574afc4120af81bdf8'

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
