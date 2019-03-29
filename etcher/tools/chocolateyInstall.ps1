$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.19/balenaEtcher-Setup-1.5.19-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.19/balenaEtcher-Setup-1.5.19-x64.exe'
  checksum               = 'ebae6307415145f64eb4213e077232ddea4219da0b391a6fed52a0aece471de3'
  checksum64             = '855a8d15df68d6a648b5caa983c46cc623923021551cb43934a271d6c7e24479'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
