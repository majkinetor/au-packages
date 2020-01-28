$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.72/balenaEtcher-Setup-1.5.72.exe'
  checksum               = 'd7ce619e2b6d21ce32e7c03613dcf9600c8cf0a17e328329d1127efad97e8da1'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
