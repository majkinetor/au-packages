$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.102/balenaEtcher-Setup-1.5.102.exe'
  checksum               = '33d1a7c0d0860382b86bed4dd0d8e4fa5e07a7bd424e4cc358238e58ba9f5e10'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
