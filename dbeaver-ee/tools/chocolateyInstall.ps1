$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/5.1.1/dbeaver-ee-5.1.1-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/5.1.1/dbeaver-ee-5.1.1-x86_64-setup.exe'
$checksum32  = '166ff7f47de50b899016a517e17e8d39a705bd199ff92df1185affcb7c4f8446'
$checksum64  = '88e7448bcafaf7d20800ded68fbc948912a7f53b2469a7270f590c77a9fcec50'

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
