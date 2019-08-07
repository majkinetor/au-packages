$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.53/balenaEtcher-Setup-1.5.53.exe'
  checksum               = '4e46323834cdfd60e5d333caf570cf6e46de4e47ee572085c307c36afcc7b7e6'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
