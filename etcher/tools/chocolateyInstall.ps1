$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.57/balenaEtcher-Setup-1.5.57.exe'
  checksum               = 'd0b6d1b90dd1769d4d45a1fd110dc07031a5a8981907f9911d72b09da4e1e981'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
