$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.103/balenaEtcher-Setup-1.5.103.exe'
  checksum               = 'bcf8a0a17ff76d7128e9e5bfa292fafdf63a54555aa423b4d777eca9763f5bb7'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
