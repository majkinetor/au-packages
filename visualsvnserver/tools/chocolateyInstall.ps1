$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.0.2-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.0.2-x64.msi'
  checksum               = '1b3615b63d05599990029e922daa23b574f4861d30f5737cb5627c502e93c40f'
  checksum64             = 'c29765e6e901961de92e8dc2a430fe730928c04e92b261e97324f98c3e9e34fe'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
