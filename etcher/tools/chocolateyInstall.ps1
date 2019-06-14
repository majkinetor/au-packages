$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.49/balenaEtcher-Setup-1.5.49.exe'
  checksum               = 'f4f1c9f337b1cc859e2ce2c3a5eed98bea5bfa29927284acb4c75952aa207198'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
