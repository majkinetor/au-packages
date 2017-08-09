$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.1.2/Etcher-Setup-1.1.2-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.1.2/Etcher-Setup-1.1.2-x64.exe'
  checksum               = '9d7f9511e04fc4a2db03fde726dc65aa602d38d81b4fa77d1c55fe86c0420022'
  checksum64             = 'e72568a6f234ed2e9982e875630e2d648ed9359a19f3f15fb073fd1cf2a4ec01'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
