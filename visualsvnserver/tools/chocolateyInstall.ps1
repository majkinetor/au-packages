$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.0-x64.msi'
  checksum               = '4665cd41fda7b6d830a0bf303e89471572ecf2a7c811bc9a0fa2b90bd17c947a'
  checksum64             = 'b691457c423c8717b9431d2e5245e69eb8ed9f62df8ca92e54145a1e9ea63859'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
