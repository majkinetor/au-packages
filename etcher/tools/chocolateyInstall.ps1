$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.15/balenaEtcher-Setup-1.5.15-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.15/balenaEtcher-Setup-1.5.15-x64.exe'
  checksum               = '8f95b5e3cd1d3219ec33da5bfec0cb0f4147e219edde4c71c47d38fd1e792a56'
  checksum64             = '796bda7de541e91b0074f78296f345853a1f308efb71fc023921aa0a3d7da66d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
