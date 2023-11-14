$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.3.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.3.1-x64.msi'
  checksum               = 'c04b9689866e654c933cba3c8d44a275d23cd94de2d2271e7e50c64272bc06dd'
  checksum64             = '5019de885f502fefacd6eb0b0589b5a4932a87b6f18616d08e2ab6bb36de34f6'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
