$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.106/balenaEtcher-Setup-1.5.106.exe'
  checksum               = '30c6ca4e2c55cb623d63c64e152892cdc216f2c38ab6472e373e9bf9df6469e9'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
