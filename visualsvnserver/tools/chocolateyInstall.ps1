$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.9.1-x64.msi'
  checksum               = '895a6e88019c9fe77cbe29979969588d0fe44ccd8fc74cba0adf2d8dc7ef02c4'
  checksum64             = '34c5353bb83cef70c6ce069df6000d271a736d96a3700cc8c7fa0493dae5bcba'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
