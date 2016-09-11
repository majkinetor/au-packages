$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.7.4/dbeaver-ee-3.7.4-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.7.4/dbeaver-ee-3.7.4-x86_64-setup.exe'
$checksum32  = 'b514d6b447083b19dc5e2223af760cb8dd928fa8fcdc22fc7619dc05e66e837f'
$checksum64  = '4d89595db64b9c5f9ef90db99ea3c8f4207e6d4839e6a9d83e11c59f1a6a343d'


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
