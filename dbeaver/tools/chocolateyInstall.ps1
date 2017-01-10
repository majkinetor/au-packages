$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.8.3/dbeaver-ee-3.8.3-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.8.3/dbeaver-ee-3.8.3-x86_64-setup.exe'
$checksum32  = '65a9046f1fa04cf8783f3c93f831bc1936f3aec759a828e92b212e5a1af3bc0d'
$checksum64  = '6284f045e23ba8baab87d73de48a4d8399169b85f349d2d6b450f9b8c59a0f4b'


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
