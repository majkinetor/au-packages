$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.76/balenaEtcher-Setup-1.5.76.exe'
  checksum               = '8dc7bdc1bdb92f082f2402cf07625031c8d182245560ae3d38992e5d834a2f63'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
