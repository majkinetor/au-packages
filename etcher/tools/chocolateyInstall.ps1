$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'etcher'
  fileType               = 'exe'
  url                    = 'https://github.com/resin-io/etcher/releases/download/v1.4.0/Etcher-Setup-1.4.0-x86.exe'
  url64bit               = 'https://github.com/resin-io/etcher/releases/download/v1.4.0/Etcher-Setup-1.4.0-x64.exe'
  checksum               = '2da225c978cde5ea29719dcdceaecb679f6efb5bfdcf121c501efcbb8c09ecf1'
  checksum64             = 'bdaf62ed34ad4e10ca97a5db711cd9a0b9f58358487ec51ef6946b34ff2b8078'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'etcher*'
}
Install-ChocolateyPackage @packageArgs
