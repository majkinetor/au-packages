$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.49.0/dnGREP.2.9.49.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.49.0/dnGREP.2.9.49.x64.msi'
$checksum32  = 'e187853731946b01f9ad4ca9438b341a52df120d49c392070d6456d93419a083'
$checksum64  = '0f2eac2911a9e643d110c80314ae689735f02d42e5afcfb3296b79baee5737fc'

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
