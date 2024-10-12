$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-5.4.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-5.4.1-x64.msi'
  checksum               = 'a21ce18b2945887a040df8b09b4b745928ea3b49b82c74fc1d81118971486010'
  checksum64             = '9a0647152ba3d5e42db6fb721923972f70b062a8d256aaafb76269833ac37e5a'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\visualsvnserver"
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
