$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.8.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.8.1-x64.msi'
  checksum               = 'f79f862dbf00c82a530604cf826d7d106396a306e73db5ebc35f580545dec849'
  checksum64             = 'dc1ce7ae17c0d94b4defd7d10bb49d643045a1225eef0469c8e58685c10e4a0d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
