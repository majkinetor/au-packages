$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.1.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.1.0-x64.msi'
  checksum               = 'dca613939eaf1fbdd57d973397cc3ec498baca53a0bd5a2e30ccaaa8de998c6e'
  checksum64             = '8a472d89e0631731aeafed812ddbba0973e9528e604a3e5f855f32535fa25c4d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
