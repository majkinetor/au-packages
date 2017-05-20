$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.42.0/dnGREP.2.9.42.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.42.0/dnGREP.2.9.42.x64.msi'
$checksum32  = '1f0f21926cfd1973cf1641eb44ec254aadd483082687c89f0d652b65e1e0e69b'
$checksum64  = 'c2398219d729657308618b81796c515163271b4fce98b745805113866b1ddc0e'

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
