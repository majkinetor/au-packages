$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.95/balenaEtcher-Setup-1.5.95.exe'
  checksum               = '803acb6f51ec67e8ccf5c77ab1e691589448123915cec28c6acd84fe57ca623f'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
