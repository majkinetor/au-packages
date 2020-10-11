$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.0-x64.msi'
  checksum               = 'f3d346e027a8d9c10034ee1b073932b8dbbddcb3f53ba7376c06f0970f79e860'
  checksum64             = '2b873fc0593693a3ead025589d4df5d48569168be61dc054fd3c7606f4e7b2de'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
