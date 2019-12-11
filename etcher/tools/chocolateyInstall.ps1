$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.69/balenaEtcher-Setup-1.5.69.exe'
  checksum               = '0d6b97f9d5c1fb0500f2cd851dfdda928c47b210454946edbdb83795423b1d46'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
