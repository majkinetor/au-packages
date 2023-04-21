$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.4-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.4-x64.msi'
  checksum               = '5f01c16e7e31d9b718016a13b2f735d32be669c3c65e62111ecadb90ce148487'
  checksum64             = 'c40096c653be2112d95bed5ec180186abec4be1a199f609973b3b1dfe19d6d4e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
