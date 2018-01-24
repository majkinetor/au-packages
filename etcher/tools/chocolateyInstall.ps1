$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.3.1/Etcher-Setup-1.3.1-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.3.1/Etcher-Setup-1.3.1-x64.exe'
  checksum               = 'e873adfbdc0acabd73edf459c0e759b978eebd23b805854b7da25c59d28eec60'
  checksum64             = 'ee9c1af71f394e2eb5cf26d1795007a671efaa97b6ad830e239102df61cfc465'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
