$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.24/balenaEtcher-Setup-1.5.24-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.24/balenaEtcher-Setup-1.5.24-x64.exe'
  checksum               = '69183116d9ca9e05f14f27832ee3d414e61f3016358a5425e6be39fa40f92118'
  checksum64             = '5dda7c8e2d634a500fffee5d713ff86fbd72d1bf526f074becab5cc6220a36b5'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
