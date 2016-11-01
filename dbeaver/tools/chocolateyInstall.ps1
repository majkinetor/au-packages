$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.7.8/dbeaver-ee-3.7.8-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.7.8/dbeaver-ee-3.7.8-x86_64-setup.exe'
$checksum32  = '0488e1d22d21c41dc18dea148707d36f3018cc4233919c6003efd839787838de'
$checksum64  = '89363a1ef8ac206bb08fb2a18867fc637c9cf38c4a968864b74717b95dc48f5b'


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
