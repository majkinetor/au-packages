$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.4.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.4.0-x64.msi'
  checksum               = '0c37afe88b247ee2f5a6034fefc919daf1be493a12b199e0a22b4224bba1473d'
  checksum64             = 'c5471d82c81cf207a5b439a5455e122064eabb5c757fcc982054db93360e9cd2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
