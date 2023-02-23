$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.3-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.1.3-x64.msi'
  checksum               = '11352d9db85f0b019f44617a613b773370829afc9dff02539a37657c29f4abf1'
  checksum64             = '1a94b924462ae92cf084acb33336cdb92c12c550731a97e92925b52d7abac56d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
