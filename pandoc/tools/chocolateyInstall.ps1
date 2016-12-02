$ErrorActionPreference = 'Stop'

$packageName = 'pandoc'
$url         = 'https://github.com/jgm/pandoc/releases/download/1.19/pandoc-1.19-windows.msi'
$checksum    = 'deedb235e891d5736d0e9151c8d152fa76b311ba67db7407488a06bc5301132c'

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

