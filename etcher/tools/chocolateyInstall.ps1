$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.91/balenaEtcher-Setup-1.5.91.exe'
  checksum               = '675716fdb7d8ffe0a231a079269385c7dc8437a15fc911a910c7d1d47f8d6c61'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
