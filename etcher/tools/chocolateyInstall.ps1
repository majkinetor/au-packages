$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.58/balenaEtcher-Setup-1.5.58.exe'
  checksum               = '2640d1de31879a2391d9fe3c919fe1ad600b20d339e35e38ca9c5c5dc3f8ad90'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
