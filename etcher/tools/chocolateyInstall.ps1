$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.1.0/Etcher-1.1.0-win32-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.1.0/Etcher-1.1.0-win32-x64.exe'
  checksum               = 'da4bc01a8ee346d631e549d16b70698575aa87e03cb01b89c8a28febf0e09e17'
  checksum64             = '02b9ae8543d20b8f2317a83f29566594d6a444fb3f27c977ea56b092ce451707'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
