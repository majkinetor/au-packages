$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.71/balenaEtcher-Setup-1.5.71.exe'
  checksum               = 'ba776a6c9e7baaa9aa092899f007e77edbfb671776dddd370a583970dbcf8c65'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
