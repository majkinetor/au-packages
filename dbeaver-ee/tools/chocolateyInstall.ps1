$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/6.0.0/dbeaver-ee-6.0.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/6.0.0/dbeaver-ee-6.0.0-x86_64-setup.exe'
$checksum32  = '9fb357a96296fe1aec09fcc90b6ac79230ef89133e2ef543dedae0ebcbe1d8ea'
$checksum64  = '3e8cd302bfd00fbb16c8734ccecb8eda911d6be40692312ffffb469905a49845'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S /allusers'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
