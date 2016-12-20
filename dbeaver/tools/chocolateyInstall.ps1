$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.8.2/dbeaver-ee-3.8.2-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.8.2/dbeaver-ee-3.8.2-x86_64-setup.exe'
$checksum32  = '08d5eda30435cf64f5a5b9dc5f71dc9e9033b3a774df8a3211cd1d4820723ec1'
$checksum64  = '8cdc2ce5644a387abc3cf2362fb41c9388c9a0fad399112814cd1138c02ec023'


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
