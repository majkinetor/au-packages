$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.105/balenaEtcher-Setup-1.5.105.exe'
  checksum               = '5735ad788e50a7254a47a9e2cfc3e5decffeb3a9060a32f0990b864769a6f3be'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
