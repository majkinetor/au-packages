$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.1.2-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.1.2-x64.msi'
  checksum               = 'e52bb3483c9a8c1c010df153a98a2b49dcfb7053fbf25064a11db3712f58e51b'
  checksum64             = '0946f5973aaf21b3cbf1e94529e0ec04dd4f8ab33dd26083d76fe029311632ec'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
