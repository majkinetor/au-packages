$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.5-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.5-x64.msi'
  checksum               = 'a77dc8861a995754898bb848330862628679cff3dbf52fda39436c86b8e98bdf'
  checksum64             = '30e6252531e4dc9d0f4416959f8cb8392024fd9a708d3b121106f573bb3bc4a7'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
