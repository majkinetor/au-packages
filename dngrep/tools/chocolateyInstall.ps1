$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.28.0/dnGREP.2.9.28.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.9.28.0/dnGREP.2.9.28.x64.msi'
$checksum32  = '158798d7e5f609832756750b1e11bca301413d76c78c898b90608159206c74ee'
$checksum64  = '408b942558e4e86316bae650ad4e73ffa5fb93986d37c9b0549659c8643ac41f'

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
