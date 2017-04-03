$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/4.0.4/dbeaver-ee-4.0.4-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/4.0.4/dbeaver-ee-4.0.4-x86_64-setup.exe'
$checksum32  = '5f900e1a142d7960abeaa5063e031adf7d9e78ca665bd16236bc7bf1d053c88b'
$checksum64  = 'afc159464306705851d4af2295b5f0d7cac1e0844400e8e9d732d9e466f1bd7e'

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
