$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/5.0.1/dbeaver-ee-5.0.1-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/5.0.1/dbeaver-ee-5.0.1-x86_64-setup.exe'
$checksum32  = '00863ad7f4e4a97d6af73369216ab50af0a40c29bad9b10488f33f65880c42ca'
$checksum64  = '8c3e4d1633929b53233ac305a568586b164bf7806d58f4022467a95dd12a02fa'

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
