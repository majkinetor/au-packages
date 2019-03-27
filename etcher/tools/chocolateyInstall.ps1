$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.18/balenaEtcher-Setup-1.5.18-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.18/balenaEtcher-Setup-1.5.18-x64.exe'
  checksum               = 'b5a75ebddfe41d384b80c5338dbf07880423d03a3473a21f0be1bf97c4c86b53'
  checksum64             = '6c7b5f0b6e34b6646d444d2258d06f01fb34ef26c82afe5e8b1ce2ddead729c8'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
