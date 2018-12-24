$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.4.9/balenaEtcher-Setup-1.4.9-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.4.9/balenaEtcher-Setup-1.4.9-x64.exe'
  checksum               = '6d76bb4f37298080ab66376184bedb670e59c3570623dd36253dc2a1074a486b'
  checksum64             = '24b6d0d174dfa5883ed313f7546d1df36794d3fe9eb0d7397ab96d6f82af2a96'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
