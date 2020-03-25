$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.80/balenaEtcher-Setup-1.5.80.exe'
  checksum               = '4d6a20dbf34816e02d51a9ce280038f11001d08bd9613aa8c17c74b704461022'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
