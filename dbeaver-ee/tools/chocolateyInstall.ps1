$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/4.0.5/dbeaver-ee-4.0.5-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/4.0.5/dbeaver-ee-4.0.5-x86_64-setup.exe'
$checksum32  = 'ac2425328ea889e5a2bdf1b3ad11e2cee4bc0dcd395c501c88d33ed95900113e'
$checksum64  = '2a265500aaadd9aeadb4cdece27c9ace5aad70627501ec77e43ac3b256a6e193'

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
