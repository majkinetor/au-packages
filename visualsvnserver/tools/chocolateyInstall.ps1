$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.4-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.4-x64.msi'
  checksum               = 'a0faf2b46c3c728e5fa3127977de4c3dd7cf526c143c379be2dad225ebce6757'
  checksum64             = 'd50ae673731a6ffe3ae18f79c061f91853028ad216bdc8f68e33e88a26376fc1'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
