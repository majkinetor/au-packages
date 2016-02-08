$ErrorActionPreference = 'Stop'

$packageName = 'soulseek'
$exeName     = 'ssk.exe'
$url32       = 'http://www.soulseekqt.net/SoulseekQT/Windows/SoulseekQt-2015-6-12.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs
