$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.0-x64.msi'
  checksum               = '1d6771081407cff7764cfb1b350891e74c8001e535a09a03fa0b3df4703efe46'
  checksum64             = 'f968ae9c74cf2bc28fc686746305f3fdcd7575db2b097e4eec094f7b94eb79ba'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
