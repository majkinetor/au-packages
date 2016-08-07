$ErrorActionPreference = 'Stop'

$packageName  = 'smplayer'
$url32        = 'http://downloads.sourceforge.net/smplayer/smplayer-16.8.0-win32.exe'
$url64        = 'http://downloads.sourceforge.net/smplayer/smplayer-16.8.0-x64.exe'
$checksum32   = '0B0F8AD8204FF7667617451E8D6EB3A749F93363A6803BB3D7DA674ED2AF81A3'
$checksum64   = 'B35FB2C15024A6ACE456DCB1DE33F2AECEBCD409A4FBB3D7593E70785F930F31'


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
