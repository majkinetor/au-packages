$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.46/balenaEtcher-Setup-1.5.46.exe'
  checksum               = 'bc028c95782a0cdcdf47b34dc303a83e04b7a9212f35329cba77c3c8ef0f8420'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
