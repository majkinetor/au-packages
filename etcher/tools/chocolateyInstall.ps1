$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.62/balenaEtcher-Setup-1.5.62.exe'
  checksum               = '560b5e6def0c7ebf8254d8735e0f6f733e19fc8db70135637933f5846372f8ed'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
