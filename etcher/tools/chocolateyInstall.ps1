$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.30/balenaEtcher-Setup-1.5.30-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.30/balenaEtcher-Setup-1.5.30-x64.exe'
  checksum               = '9da3fe1dbc17192d56d38899d4b23f850a0d5c66193325fd8be5cc3ee630e59b'
  checksum64             = 'c9f36435d4c600ea8ce195d816b2df7f2963bc3a01da12d86b908d85d0d932b3'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
