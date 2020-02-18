$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.77/balenaEtcher-Setup-1.5.77.exe'
  checksum               = '0ee5ae5f7508675cf50f7d94e491adab4e1cf30451551aac215efdf12afdba9a'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
