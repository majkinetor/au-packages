$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.4.7/balenaEtcher-Setup-1.4.7-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.4.7/balenaEtcher-Setup-1.4.7-x64.exe'
  checksum               = '166c80092471a6db86fbc96c2885f8cb2e5b5613aefe3a33d551df35ae4627d0'
  checksum64             = '26ce9c13fa57c96570c385ddc5b323c9c5a9fa255168bfa4d91a93a9a1a42d99'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
