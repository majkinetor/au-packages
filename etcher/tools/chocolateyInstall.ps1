$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.56/balenaEtcher-Setup-1.5.56.exe'
  checksum               = '9601a7fa0e470f3f28333792fdc21febee88947d6ab382b9146d5d40a62e7896'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
