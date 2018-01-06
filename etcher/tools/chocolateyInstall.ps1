$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.3.0/Etcher-Setup-1.3.0-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.3.0/Etcher-Setup-1.3.0-x64.exe'
  checksum               = 'ece51fd7d4db94dec2a1bbff40e75ebc29f1f4430e97527316fc3eebdf12a793'
  checksum64             = '083954f50c0c8ba94b58396c2824a76757f085593607a5db820c863dfc48c4d1'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
