$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://resin-production-downloads.s3.amazonaws.com/etcher/1.0.0/Etcher-1.0.0-win32-x64.exe'
  url64bit               = 'https://resin-production-downloads.s3.amazonaws.com/etcher/1.0.0/Etcher-1.0.0-win32-x86.exe'
  checksum               = '9674086dccd22a40e42f46f094c6eca8eb61a70cf1e65ae0225df0b3ba1307b6'
  checksum64             = '71ca10bb4c4950fba43cddfe1d43951cf1ed66d3636c6dcfbfac07c81c172e58'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
