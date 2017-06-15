$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.53.0/dnGREP.2.9.53.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.53.0/dnGREP.2.9.53.x64.msi'
$checksum32  = 'cef8314ab05a5abb3ef9339bee8b1c563e6c984940b4a7325485eb9386967fe8'
$checksum64  = 'ab2239d2e911296173391a7627469e71b24371daf0e25b058ed0ae06956266b3'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url32
  url64bit       = $url64
  silentArgs     = '/quiet'
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
  softwareName   = "dngrep*"
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
