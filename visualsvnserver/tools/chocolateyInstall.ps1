$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.4.3-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.4.3-x64.msi'
  checksum               = '067be4c7104e60404c0c16580140f1525ab92bb297fcd5660333c31105f5223f'
  checksum64             = '529b277d335ed0e2c6607632de32f962f431d2bc1894c52502084336920e8c56'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
