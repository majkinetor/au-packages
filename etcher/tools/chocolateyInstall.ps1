$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.4.4/Etcher-Setup-1.4.4-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.4.4/Etcher-Setup-1.4.4-x64.exe'
  checksum               = '0305f7db4a6505ad3d2f101dea734cc62b51c9c9ead397cd257fc08d1f857ccb'
  checksum64             = '432203b640ace82b91a951146bd4d45fdc60ed0d9e91140abfa275a2108bee6c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
