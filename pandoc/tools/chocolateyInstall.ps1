$ErrorActionPreference = 'Stop'

$packageName = 'pandoc'
$url         = 'https://github.com/jgm/pandoc/releases/download/1.19.1/pandoc-1.19.1-windows.msi'
$checksum    = '01965414eb03a66b9d49c334e7e635b90518005530f9c8d619c30200403b6a19'

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

