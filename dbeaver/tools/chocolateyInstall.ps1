﻿$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.7.2/dbeaver-ee-3.7.2-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.7.2/dbeaver-ee-3.7.2-x86_64-setup.exe'
$checksum32  = '334BEB5B99BED5710014BC88FAFCD383E51AF804EF318A497A585CDD1DD271B3'
$checksum64  = '11A78D953B0AF052484E6C18F50D6ECE8930931DCC3BA6F3DCF0BFB1E56CAABD'


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
