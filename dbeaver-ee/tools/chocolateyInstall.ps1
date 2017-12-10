$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/4.3.0/dbeaver-ee-4.3.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/4.3.0/dbeaver-ee-4.3.0-x86_64-setup.exe'
$checksum32  = '348c9b03f6ba2cbd3c42de0c499816ae8bdf604e7a77a7defd51979a56f0f14e'
$checksum64  = '1c94bdc67a552bb55dc4452bd2bd7740965bbb94b18cda642bb6112d6a13bc2d'

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
