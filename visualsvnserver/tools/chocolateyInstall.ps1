$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.5-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.5-x64.msi'
  checksum               = '1e251be6532f07427ea51d4dc4404d029bcd74e95a090ddc1df66af3fef056b7'
  checksum64             = 'e90feb8222991e7a4c466c2321f8f3461b603ef4f74e7aa58a30b9e46f63c4f4'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
