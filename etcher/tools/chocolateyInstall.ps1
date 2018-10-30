$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.4.6/Etcher-Setup-1.4.6-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.4.6/Etcher-Setup-1.4.6-x64.exe'
  checksum               = '1bd33e28566b1c969a29699d61f4b8a9d145412a1e19ead1e828babb9bd8dfc4'
  checksum64             = '3a8fc81c35e4d1d76716930ed91791fd4ba96c63edbbe22674dc8e39896bf245'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
