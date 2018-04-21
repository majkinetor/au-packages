$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.4.3/Etcher-Setup-1.4.3-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.4.3/Etcher-Setup-1.4.3-x64.exe'
  checksum               = '1e9b73e73ad5fb207af5a9e19c4b70b07f418d52827163aac7bba5b024c427a7'
  checksum64             = 'cc68a33afc1c08067be85eae4f9617aa16979f35a992a775dadb395190731068'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
