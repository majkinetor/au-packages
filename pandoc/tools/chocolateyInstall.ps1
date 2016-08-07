$ErrorActionPreference = 'Stop'

$packageName = 'pandoc'
$url         = 'https://github.com/jgm/pandoc/releases/download/1.17.2/pandoc-1.17.2-windows.msi'
$checksum    = '7E96A0D66C3C96841C15E01D3CEC863D470293F12C28EAB0CEE160285EABFA40'

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

