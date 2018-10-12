$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.4.5/Etcher-Setup-1.4.5-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.4.5/Etcher-Setup-1.4.5-x64.exe'
  checksum               = '247c84161c49cd6efb15e87c2d579e6a304b8e109985bc795bf4a3fbc337af2b'
  checksum64             = 'b4416f239122383660fc1f118c52feaef5b493c3fb5bc0b28c46977113ad9ed6'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
