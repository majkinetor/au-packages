$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.1-x64.msi'
  checksum               = '662549c1c8fdd8f6602bd5f130ed62ded783d06c0ac1a1d84ac10657ef270018'
  checksum64             = '6c8a596543c3012ecd7e00a68675e80c6c54e2200eb9b4293026f0928b56f00f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
