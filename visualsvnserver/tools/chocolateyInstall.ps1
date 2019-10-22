$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.1.3-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.1.3-x64.msi'
  checksum               = 'bb613c18d24812639da938526d0fca89efc88b8b9736a04920cdeefea04ac684'
  checksum64             = '9dd0969de868c633416cf4df04ec04f69dcf0196e6311396084c294c46e8559c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
