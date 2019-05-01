$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.33/balenaEtcher-Setup-1.5.33-x86.exe'
  url64bit               = 'https://github.com/balena-io/etcher/releases/download/v1.5.33/balenaEtcher-Setup-1.5.33-x64.exe'
  checksum               = 'f1587d3c37d5a72896e2c4954b94b7fc1c5376b0c582d0ce83481867949d068f'
  checksum64             = 'f613f40fba95ebf3aa92654ad0e670100f42ac8888ba253ac99a5f4495dfa2db'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
