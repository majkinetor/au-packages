$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.2-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.2-x64.msi'
  checksum               = '2356664d0e4f31a1b7eebd443cc93bbab0bf78edcdd752f9234d0a4a5ac9da5b'
  checksum64             = '34d7a4dc512fa97c46dcddb5608100a3abe636704fda9193711ad78c37e8c2e3'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
