$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.7.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.7.1-x64.msi'
  checksum               = '5359c65296b0fe5c45af703f7a65c0ccc8fa388890274619e1766a7c0f0ce795'
  checksum64             = '30999ff7dcc837120f0e9c86cb71ac0c88fec401ddb0229fd0b5a7b2842ffca5'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
