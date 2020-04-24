$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.2.2-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.2.2-x64.msi'
  checksum               = '20c26265c293e8c1c5a774d0fed97e12e5cb50f89d5db986adf9147790f69b30'
  checksum64             = 'fb41646dee904f105a82fa0dd1d88de382f5d457c5368e2b95fb9e2a8056d1d3'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
