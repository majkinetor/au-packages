$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.22/balenaEtcher-Setup-1.5.22-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.22/balenaEtcher-Setup-1.5.22-x64.exe'
  checksum               = 'c0d23ac7d2b856df379e3d11d77a2c256a84a353bf033a9f48e95f531d9b627e'
  checksum64             = 'f7f7d0d2efe01d8990b29a58ae9332139aef3f1a4361bbcc87a5d5eacaa99ff3'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
