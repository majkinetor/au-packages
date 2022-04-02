$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.0.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.0.0-x64.msi'
  checksum               = '6727523f02ceb951459a17c2b8bbd4f8b8a8d2908a9fbf748fdf9f698a29b9a8'
  checksum64             = 'f204dd6b142b10cf9aafcc188977221495607db78515cffcd82c6b60b3e34111'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
