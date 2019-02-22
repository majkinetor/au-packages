$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'signal'
  fileType               = 'EXE'
  url                    = 'https://updates.signal.org/desktop/signal-desktop-win-1.22.0.exe'
  checksum               = 'b367a5b57e869e2dcda08a01738606b6c38590d3a47de57d134b8b4f4f5a2a54'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Signal *'
}
Install-ChocolateyPackage @packageArgs

