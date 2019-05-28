$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.43/balenaEtcher-Setup-1.5.43.exe'
  checksum               = 'fc6a5eddb29bc5770bc4413e6e9c0eb957f3f3095ff41ab9751622438bd24cef'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
