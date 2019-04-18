$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'signal'
  fileType               = 'EXE'
  url                    = 'https://updates.signal.org/desktop/signal-desktop-win-1.24.1.exe'
  checksum               = '275c6717d5072f45cf3cf0dc0f5d6e62c143213e5143941ca81bb46be9c7e614'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Signal *'
}
Install-ChocolateyPackage @packageArgs

