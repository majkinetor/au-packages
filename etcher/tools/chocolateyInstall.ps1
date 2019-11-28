$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.64/balenaEtcher-Setup-1.5.64.exe'
  checksum               = '8a19379f32bb47630716d090ba5578de5edbe070f41a97d9fa45f3dd21537a6e'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
