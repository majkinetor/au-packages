$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.8.4/dbeaver-ee-3.8.4-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.8.4/dbeaver-ee-3.8.4-x86_64-setup.exe'
$checksum32  = '1dec4ef584130724bcf935a6239b397d8198ec0d617361a48c7f420cb0aeed0f'
$checksum64  = '088c0501c034c3d6ab56669c6d1236d9fcb9938cbb52b6c98f48523d59dd633a'


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
