$ErrorActionPreference = 'Stop'

$packageName  = 'smplayer'
$url32        = 'https://downloads.sourceforge.net/smplayer/smplayer-16.9.0-win32.exe'
$url64        = 'https://downloads.sourceforge.net/smplayer/smplayer-16.9.0-x64.exe'
$checksum32   = 'a7dd43d91712c8db1febc56809bcf0537a85e5839eb9e73ee018c772b851bc8a'
$checksum64   = '394260c807956dab59fdf807915a7c6f5385a20f61ab107b58a0a5bf19ad58de'


$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
