$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'signal'
  fileType               = 'EXE'
  url                    = 'https://updates.signal.org/desktop/signal-desktop-win-1.16.1.exe'
  checksum               = '1d97819e93767f2cee157c62f608ad4cbe38d896f189dd58de4284e6e0ed5696'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Signal *'
}
Install-ChocolateyPackage @packageArgs

