$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.35/balenaEtcher-Setup-1.5.35-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.35/balenaEtcher-Setup-1.5.35-x64.exe'
  checksum               = '1a911fed47b3309307383c4ca0588e715990707c117348296500812d94e5714f'
  checksum64             = '30b0dedcf0b1636249929196adb059adbfa136cf45b918603e1ac1b246a33247'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
