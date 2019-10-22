$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.60/balenaEtcher-Setup-1.5.60.exe'
  checksum               = 'fed87029e0158cf32f91a2b3405bde6c9a1f1fe70fd4696fd04623351aa6d5e4'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
