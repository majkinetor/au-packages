$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.52/balenaEtcher-Setup-1.5.52.exe'
  checksum               = 'd0e4bf19abfa2576ec35f2dcfa0d9d473f11c613ae1734e09f5e25bb386b2bf6'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
