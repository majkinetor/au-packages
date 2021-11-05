$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.5-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.5-x64.msi'
  checksum               = 'bd91ec1dba9a39fcc823053bff404c4df75724530d6a9b6fff88df784d238751'
  checksum64             = 'e07712840f5703bf0cd20cf6a2f99a6085a420bbde0201af72d1cbe1be46651a'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
