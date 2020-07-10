$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/balena-io/etcher/releases/download/v1.5.101/balenaEtcher-Setup-1.5.101.exe'
  checksum               = '9e8f848aa4095d85f8915574faf026a435fd7d01c52de6c8754d9d888e87be0e'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
