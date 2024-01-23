$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.3.2-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.3.2-x64.msi'
  checksum               = '6e394a1efd5429cca15e2b38f2f7240849993d1aa1cb071e536efeb7c9178805'
  checksum64             = '420e1075148cea85288bb549efc8a4af051d8a3feb179c1e2d4ec132ba1c272e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
