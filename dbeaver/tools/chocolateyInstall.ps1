$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.7.7/dbeaver-ee-3.7.7-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.7.7/dbeaver-ee-3.7.7-x86_64-setup.exe'
$checksum32  = '864ea6be64be3aec31ff785ec83fad898510cb3591644263cfd2b0296b584999'
$checksum64  = 'f6c2e9e092a7c3bb74d11c00cc2a9983cc5b818fe52eb4fc9a5d53f34d65158a'


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
