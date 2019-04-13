$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.26/balenaEtcher-Setup-1.5.26-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.26/balenaEtcher-Setup-1.5.26-x64.exe'
  checksum               = '4caf4338700db52d460136a13759a7ffe2faa9d78b005701f3f30d933c4d109f'
  checksum64             = '6d4e37162699e979de85c8e71567446aef3b30bfb4db2832437c8741c1f5aa35'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
