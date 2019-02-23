$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.0/balenaEtcher-Setup-1.5.0-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.0/balenaEtcher-Setup-1.5.0-x64.exe'
  checksum               = 'c83b214594a15a414431a642cc67c77a1dbb04d45ac6636211c386e1c53a4e54'
  checksum64             = '327bc0c4c3cdc5da67b5b9554c57cffd21e55c3ede5778668852f5abd3a1396c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
