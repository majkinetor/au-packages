$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.5/balenaEtcher-Setup-1.5.5-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.5/balenaEtcher-Setup-1.5.5-x64.exe'
  checksum               = 'a91c24b214d0879f1500627719ec08de3f72751e09d188c36e7eca5a04fb56c3'
  checksum64             = '3c4975873eda2d38f889d869217e039da510423d1409985a02e0469004f968f1'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
