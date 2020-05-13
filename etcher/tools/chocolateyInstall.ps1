$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.88/balenaEtcher-Setup-1.5.88.exe'
  checksum               = '96960036a9b8dccbeed2f6e0b8950af9c0ec8f06f3ce3376b72110d38a49a02c'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
