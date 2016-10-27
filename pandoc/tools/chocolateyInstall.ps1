$ErrorActionPreference = 'Stop'

$packageName = 'pandoc'
$url         = 'https://github.com/jgm/pandoc/releases/download/1.18/pandoc-1.18-windows.msi'
$checksum    = '30c308603a960c69a72710f0e56ba0e60e1556d76a83dc6034f52af89871ad8b'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'msi'
  url                    = $url
  checksum               = $checksum
  checksumType           = 'sha256'
  silentArgs             = '/quiet'
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

if ($installLocation) {
    Write-Host "Adding $packageName to the PATH if needed"
    Install-ChocolateyPath $installLocation "Machine"
}

