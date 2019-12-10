$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.68/balenaEtcher-Setup-1.5.68.exe'
  checksum               = '2edae3641a244c34be8109dfe702240a94b663539ebedf965cbc6ecb3e06cc05'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
