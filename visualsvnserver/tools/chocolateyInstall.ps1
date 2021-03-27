$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.3-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.3-x64.msi'
  checksum               = 'd947131cb81a8524c574cf1d2e0984595b1c980df82e6f1a06541a55a5f85c87'
  checksum64             = 'a378fe4a70dcf715ecbffc8f51275f6f2373b6f4c9ca80da7da604a58a2a2852'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
