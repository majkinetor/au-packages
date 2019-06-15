$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.50/balenaEtcher-Setup-1.5.50.exe'
  checksum               = '8fedaf6c0556eeb2b4f9df6f1813d02934b40fca5f1a4feb87fa3d479b6b5d3a'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
