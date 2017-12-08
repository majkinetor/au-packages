$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.2.1/Etcher-Setup-1.2.1-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.2.1/Etcher-Setup-1.2.1-x64.exe'
  checksum               = '1dce9c92d3a9c5622321e1888216d415a22f2dafeee9634d1aae00a27a858879'
  checksum64             = 'fe68bf14b04798d47a0aa7f6b769756469925b71785861cc7d94890c6e9653f1'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
