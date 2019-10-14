$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.59/balenaEtcher-Setup-1.5.59.exe'
  checksum               = 'c90a93e6d15ab888ffdf553ad83e41a8b674c055ca319f2349563559b8deb4dc'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
