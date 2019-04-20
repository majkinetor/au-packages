$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.28/balenaEtcher-Setup-1.5.28-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.28/balenaEtcher-Setup-1.5.28-x64.exe'
  checksum               = '10349608117eedce9e00f4ef2e9d354890d556c982c835a96c53be1c739df7cf'
  checksum64             = '097aae41b7d956b9ad2ba70a356d20efb64de23c1bf688de37ae1fddd55a3b8c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
