$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.8.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.8.0-x64.msi'
  checksum               = '16a2ece287e6791ce6dfeebc7752b167f14154dc1f52948f2becbbb6021395af'
  checksum64             = '4b052b7cca9c89a328cb6c2f32cc4a9108f24c71b7ef16ac01f61aea40354f97'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
