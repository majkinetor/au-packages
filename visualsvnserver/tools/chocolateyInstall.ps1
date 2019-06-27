$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.2-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.0.2-x64.msi'
  checksum               = 'aaf746ab63532209c5713d64e9bacd6272c43ecb8fbad857c49c59cfb142a1db'
  checksum64             = '72fdb3496576c2a7ac3dcb67eb6d712301e614afabc5d7f116ecb597e8f55a30'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
