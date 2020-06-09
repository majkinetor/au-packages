$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.97/balenaEtcher-Setup-1.5.97.exe'
  checksum               = 'c9eef0bf2ad20adb59c7ee6a8e103c36ddb02bd0853cdd7cdfcd9d40fc693434'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
