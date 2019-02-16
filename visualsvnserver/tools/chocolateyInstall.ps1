$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.3-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.3-x64.msi'
  checksum               = 'c621e64f1fb334858a8e21a601b79f75a181eb8100dd604622104d2879972f76'
  checksum64             = 'fb1c5f2181b70929a4a9f65f2b69c00a8192e3afbad1f7116376e0a38cd603fc'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
