$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.0.3-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.0.3-x64.msi'
  checksum               = '6ee2d290a76d9ea0e08d9f2f648a9473edbce362f34f653204932adb3ec84352'
  checksum64             = 'a15b2658d58782613ef03433e21e0ba820c5c79efc9d76c445be77666e1f682e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
