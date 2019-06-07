$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.1-x64.msi'
  checksum               = 'fa1f02787cd01713240853d9da0d7199890deabf0285f77de67b8a9cc3a79d12'
  checksum64             = 'e5f3eec589c85bde3993ca6ae195a03e9994bc09c2501701d707f5cd2329a069'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
