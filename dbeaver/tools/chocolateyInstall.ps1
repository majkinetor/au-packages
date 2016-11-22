$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.8.0/dbeaver-ee-3.8.0-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.8.0/dbeaver-ee-3.8.0-x86_64-setup.exe'
$checksum32  = '83a1d466fa5a1ca6ef61f32e52540a3d9956379fb1cedbbbb40cce24318dacc9'
$checksum64  = '0dd149863edc16a68d054d739ca3922b16d88a6a1d3b2182a9527fa65406edc2'


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
