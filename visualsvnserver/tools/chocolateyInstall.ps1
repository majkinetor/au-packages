$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.3.0-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.3.0-x64.msi'
  checksum               = 'f36f1c3b42db53623ab6df96002023c7504710895b5eedaadbdb1d54cf00074e'
  checksum64             = 'a77fecb5be27df7c21641cba726952e51c01946329df69d58947d72bb1165e78'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
