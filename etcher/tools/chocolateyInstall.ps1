$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.2.0/Etcher-Setup-1.2.0-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.2.0/Etcher-Setup-1.2.0-x64.exe'
  checksum               = '51556f9a5d863f855f4bd8f8e16e732867a234e5be36108166584aa1a7ef58fc'
  checksum64             = 'a7fb395ef58dd2f7ab7bcff5d679d8251fed37d0039789a814689869f8c61c0d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
