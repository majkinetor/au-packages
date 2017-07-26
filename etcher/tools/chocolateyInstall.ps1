$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.1.1/Etcher-1.1.1-win32-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.1.1/Etcher-1.1.1-win32-x64.exe'
  checksum               = '93b81648b418f0fe90d6da011c931918597db5203540e1df620a358cff4ed437'
  checksum64             = '73634b46ea016d52b0f31d2bb55b0bd7733a3d8c024e1690cb64ece1966c5693'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
