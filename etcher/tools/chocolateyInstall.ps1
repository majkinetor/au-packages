$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.99/balenaEtcher-Setup-1.5.99.exe'
  checksum               = 'c99dde1216e7369092f77ac5e17f54e1c2971b1db822b4fb5fd3810c597ddb08'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
