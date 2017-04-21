$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.31.0/dnGREP.2.9.31.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.31.0/dnGREP.2.9.31.x64.msi'
$checksum32  = '373159291a29825d5c6593e3e830ba445cbae4fca69ea4f69a91f36f47b0e4bf'
$checksum64  = '35d7c6faed329d46db238a8ee6d690ec3922758b854a9b2bbd20954ed9a5bd3a'

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
