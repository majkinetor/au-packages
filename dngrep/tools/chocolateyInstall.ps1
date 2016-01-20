$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x64.msi'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x86.msi'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'MSI'
  url                    = $url32
  url64bit               = $url64
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs
