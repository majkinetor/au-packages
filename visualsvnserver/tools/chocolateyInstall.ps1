$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.4.2-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.4.2-x64.msi'
  checksum               = '4aba08d3e24f5c4a72d115b8e9c278ba9be0ce6b90ca0fe75db224bbc4651b79'
  checksum64             = '3504bf1bb15303029d4336ca8beab5e1ed87c01e7f45539211c0d3ae9b0a9bab'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
