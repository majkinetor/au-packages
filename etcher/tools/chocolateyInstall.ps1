$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.78/balenaEtcher-Setup-1.5.78.exe'
  checksum               = 'd89c279b380e89cfb0ed0779ef2023fb42e45f3e5285bb1a8d83c3e9541edb73'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
