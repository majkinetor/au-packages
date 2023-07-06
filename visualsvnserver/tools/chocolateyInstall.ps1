$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.2.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.2.0-x64.msi'
  checksum               = '08da18ad106afa8f0f29a71a0f34b95af61957866a2c4bf8608d8eb71212f897'
  checksum64             = 'e61f359cf7dfb0d451aa7f1688415c4ca2f3381c03d613ff08dae62d0fa59872'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
