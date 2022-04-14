$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.0.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.0.1-x64.msi'
  checksum               = '72d57a4f4c71e9e17d208150ae8d17455b0c1d13f03265b1e9fd9c705f306a20'
  checksum64             = 'a1f317250ef1a5c8f571f81285b9c00f9523702da2283a33b34b861e0c9db718'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
