$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.4.1/Etcher-Setup-1.4.1-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.4.1/Etcher-Setup-1.4.1-x64.exe'
  checksum               = '65f7f73afa3563ce42decda859d94002fd2e9ea7e166374168f771af5047730e'
  checksum64             = '15ae5febf072f953a91488b3a5a8f701f6ee10ea2a69dd0772bdd99bd7905b74'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
