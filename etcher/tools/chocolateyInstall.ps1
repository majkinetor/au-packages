$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.39/balenaEtcher-Setup-1.5.39-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.39/balenaEtcher-Setup-1.5.39-x64.exe'
  checksum               = '1cf7b2edafe0b13070faef80b1143351848080a833a8174a31bde6b9d539a373'
  checksum64             = 'deb5e27c9b655b792f0f2d07d396df53083410cc60984771df13fd1952538496'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
