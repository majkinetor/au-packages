$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.0-x64.msi'
  checksum               = '71c2b9e89dc4474200a2fd1378c3a85df32bcbb52625c2693152325c875f37b6'
  checksum64             = 'e32826248a5afbedae7f55c413ce2b1e362692be0b0b84fd1c82c10312a390df'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
