$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.7.6/dbeaver-ee-3.7.6-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.7.6/dbeaver-ee-3.7.6-x86_64-setup.exe'
$checksum32  = '2280eee6cbe216b6527233a5513e466d39458e73c020dae825d10d7671a2e547'
$checksum64  = 'a8089f5f73317f7391d181fb6f9e48d8119b78546c028cefca1e6840d2c3c5b0'


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
