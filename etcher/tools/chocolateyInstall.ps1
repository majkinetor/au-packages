$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.25/balenaEtcher-Setup-1.5.25-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.25/balenaEtcher-Setup-1.5.25-x64.exe'
  checksum               = '5260fea3e79ca477988f4342291484f146cf3c06306a25cd2c68d42609833fb7'
  checksum64             = '5961bbc0848190b79e8cbfe43035bd4edeae1f5f8851aa1ad6c7fc2789244273'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
