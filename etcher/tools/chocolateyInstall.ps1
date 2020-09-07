$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.107/balenaEtcher-Setup-1.5.107.exe'
  checksum               = '63467b94cca4c6bf8c536b6de7d1b692f3c5ff2558ae46a1090eea8358d41574'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
