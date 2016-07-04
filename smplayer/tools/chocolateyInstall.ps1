$ErrorActionPreference = 'Stop'

$packageName  = 'smplayer'
$url32        = 'http://www.fosshub.com/SMPlayer.html/smplayer-16.7.0-win32.exe'
$url64        = 'http://www.fosshub.com/SMPlayer.html/smplayer-16.7.0-x64.exe'

$url = if ((Get-ProcessorBits) -eq 64) { $url64 } else { $url32}
$url = Get-UrlFromFosshub $url

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64bit               = $url
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
