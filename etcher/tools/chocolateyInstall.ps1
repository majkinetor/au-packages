$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.4.8/balenaEtcher-Setup-1.4.8-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.4.8/balenaEtcher-Setup-1.4.8-x64.exe'
  checksum               = 'd9efa763fbe6731ccba403496cf2db66b7fc616cebd40d979445fbe31d8b0f33'
  checksum64             = 'b8f8114cc2e106c2a9bd4b1855180f547b7da6ffbcb763c66a8d0d3a1655fb0c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
