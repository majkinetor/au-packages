$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.23/balenaEtcher-Setup-1.5.23-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.23/balenaEtcher-Setup-1.5.23-x64.exe'
  checksum               = 'a68144ae33db254b50c4fd3d8c16938f8895db9439a235787fd2ecaafdbfe6e6'
  checksum64             = '5d76bbf2435b97090e40fef66ddb9e29f8c2ba57c24902dc74b9e0dbd6f15583'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
