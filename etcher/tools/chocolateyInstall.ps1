$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.100/balenaEtcher-Setup-1.5.100.exe'
  checksum               = '36dfac596c220a7c23108bbb385643bb42932b1d8b563d52c6c4eda79b5323a8'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
