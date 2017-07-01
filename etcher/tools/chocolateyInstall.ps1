$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://resin-production-downloads.s3.amazonaws.com/etcher/1.0.0/Etcher-1.0.0-win32-x86.exe'
  url64bit               = 'https://resin-production-downloads.s3.amazonaws.com/etcher/1.0.0/Etcher-1.0.0-win32-x64.exe'
  checksum               = '71CA10BB4C4950FBA43CDDFE1D43951CF1ED66D3636C6DCFBFAC07C81C172E58'
  checksum64             = '9674086DCCD22A40E42F46F094C6ECA8EB61A70CF1E65AE0225DF0B3BA1307B6'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
