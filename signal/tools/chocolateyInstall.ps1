$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'signal'
  fileType               = 'EXE'
  url                    = 'https://updates.signal.org/desktop/signal-desktop-win-1.26.0.exe'
  checksum               = '01c1c4c73e308fb1db205d17f4cdc281f9e1583fc4a2aa8b18157de98ddc38f2'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Signal *'
}
Install-ChocolateyPackage @packageArgs

