$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.40.0/dnGREP.2.9.40.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.40.0/dnGREP.2.9.40.x64.msi'
$checksum32  = '50929f259ab5c7fa914a12833728f915e19bba2dd05d7efa1a79b9460f5e2223'
$checksum64  = 'b7d593a31069b4379a146696b1f21e71bfca413defb0d2e7648f7ed915a37840'

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
