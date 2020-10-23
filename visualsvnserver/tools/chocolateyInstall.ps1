$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.1-x64.msi'
  checksum               = '04936b95bfa37b6715791b25852eefa94dbae2d8aec821cd9ea0447f87cceb7f'
  checksum64             = '79fed21d0b3437a6635d1d86dad76c6bc4c9df9cf751ad2de6e7a41978d53149'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
