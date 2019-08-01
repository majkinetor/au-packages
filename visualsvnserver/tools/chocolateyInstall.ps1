$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.3-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.3-x64.msi'
  checksum               = '10de6d49b54da5ae7604aab9d7f13df3365f8656d4004a5a381f15d80ec56743'
  checksum64             = 'cf629478f65ecb1a65ffaa6965746f88e48f368eac0800b97376e9cae00fc1a4'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
