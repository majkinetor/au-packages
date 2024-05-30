$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.3.3-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.3.3-x64.msi'
  checksum               = '3b38af27be30a07838b13b7e7c619a8713fed206021f25224db26909990185f3'
  checksum64             = 'fbec3c6c1a1fa958ed2b48ff401cd4bee94ef7c619f9de9ab6ae89a5db06328a'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
