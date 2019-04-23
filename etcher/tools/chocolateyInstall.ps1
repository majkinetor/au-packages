$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.29/balenaEtcher-Setup-1.5.29-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.29/balenaEtcher-Setup-1.5.29-x64.exe'
  checksum               = 'ed5f3969bd18eff0683f2d7133a42ed56ce6e2573329e5844dfb5409559cc831'
  checksum64             = 'f8345fc25b4b28b0e3ce0aa4da148232e2ed7dfda4aab35d1e88ff2f99d15a8d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
