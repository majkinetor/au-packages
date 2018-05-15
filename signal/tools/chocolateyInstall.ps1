$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'signal'
  fileType               = 'EXE'
  url                    = 'https://updates.signal.org/desktop/signal-desktop-win-1.11.0.exe'
  checksum               = 'a67d9f020c3196035c05a596729f70153ed4c992b9f97742aa85b930e1e3d47d'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Signal *'
}
Install-ChocolateyPackage @packageArgs

