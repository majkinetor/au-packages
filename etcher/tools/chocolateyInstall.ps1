$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.20/balenaEtcher-Setup-1.5.20-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.20/balenaEtcher-Setup-1.5.20-x64.exe'
  checksum               = '02b073432b79aa59f2112056e1621d0b56ce2a2e2daa3a7cae7fdd7046ccfe06'
  checksum64             = 'd462ce5f323f0979c1ed5331fb56d0032cda93de418c765b0c55d192dfd3cb43'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
