$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.2-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-4.3.2-x64.msi'
  checksum               = 'db0e3c643eb371b5e19d0820456465b70bd59f7a484f8170bdecd412f70aca86'
  checksum64             = '96cfb52cc9e83a6eb14654c24044bf57b6bc494a0b40e4a6d08691a7b2ba65cb'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
