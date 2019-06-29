$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.51/balenaEtcher-Setup-1.5.51.exe'
  checksum               = 'c102751291ec2ae18d4bed9cf9f25f38c2e0d18ae5bef5a78a715016dbcb7137'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
