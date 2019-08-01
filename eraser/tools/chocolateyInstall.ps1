$ErrorActionPreference = 'Stop'

$packageName = 'eraser'
$url         = 'https://sourceforge.net/projects/eraser/files/Eraser%206/6.2/Eraser%206.2.0.2983.exe'
$checksum    = '8dab1160e05d0600ead6628acd113f126fba9cf0e47ea82a53d41c8147dfb934'

$setupDir    = Get-PackageCacheLocation

$packageArgs = @{
  packageName    = $packageName
  url            = $url
  url64Bit       = $url
  checksum       = $checksum
  checksum64     = $checksum
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $setupDir
}
Install-ChocolateyZipPackage @packageArgs

$msi_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
    ls "$setupDir\*eraser*x64*.msi" -Recurse | select -Expand FullName
} else {
    ls "$setupDir\*eraser*x86*.msi" -Recurse | select -Expand FullName
}
if (!(Test-Path $msi_path)) { throw "Unpacking failed" }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  file           = $msi_path
  silentArgs     = '/quiet'
  validExitCodes = @(0)
  softwareName   = "Eraser"
}
Install-ChocolateyInstallPackage @packageArgs
rm -force -r $setupDir\eraser\* -ea 0

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation) { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

