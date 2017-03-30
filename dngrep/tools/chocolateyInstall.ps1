$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.24.0/dnGREP.2.9.24.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.24.0/dnGREP.2.9.24.x64.msi'
$checksum32  = '054b79000757066880cda234da6f1104df9c8a425a687b0ff36ae2eb2fcc24f8'
$checksum64  = 'f34bdb6f7f6e54ea6130a68d3560a21581fdf6c82223a3f1346510e0a390e214'

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
