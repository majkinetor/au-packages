$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'visualsvnserver'
  fileType               = 'msi'
  url                    = 'https://www.visualsvn.com/files/VisualSVN-Server-3.7.1-win32.msi'
  url64bit               = 'https://www.visualsvn.com/files/VisualSVN-Server-3.7.1-x64.msi'
  checksum               = '5359C65296B0FE5C45AF703F7A65C0CCC8FA388890274619E1766A7C0F0CE795'
  checksum64             = '30999FF7DCC837120F0E9C86CB71AC0C88FEC401DDB0229FD0B5A7B2842FFCA5'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'VisualSVN Server*'
}
Install-ChocolateyPackage @packageArgs
