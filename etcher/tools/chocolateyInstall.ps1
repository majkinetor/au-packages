$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.54/balenaEtcher-Setup-1.5.54.exe'
  checksum               = 'a29c2e750a0dbade8ac37666d0c1064af8d7813e31ba0596f98c3d60e2f7959d'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
