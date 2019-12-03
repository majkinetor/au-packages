$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.65/balenaEtcher-Setup-1.5.65.exe'
  checksum               = 'dc2fcc40eb7ed7a1d9ebdf35fe749c0e4b67e27698f6dac05c73a409b2d2f436'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
