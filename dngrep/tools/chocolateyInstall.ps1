$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.21.0/dnGREP.2.9.21.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.21.0/dnGREP.2.9.21.x64.msi'
$checksum32  = '87a35e828c5ded1d1f7e15ae8b3261502b8680e0ff0ab13720f14f055529c913'
$checksum64  = 'b1de577e9a2c76ae432995d542e9dd95ca70931c1c68e4e99787a1f82c75c4f7'

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
