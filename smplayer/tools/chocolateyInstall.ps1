$ErrorActionPreference = 'Stop'

$packageName  = 'smplayer'
$url32        = 'http://www.fosshub.com/SMPlayer.html/smplayer-16.7.0-win32.exe'
$url64        = 'http://www.fosshub.com/SMPlayer.html/smplayer-16.7.0-x64.exe'
$checksum32   = '54fd0c0b13d0350154e6aac4eaba4863d804788f733fc9a25364fb983edc6413'
$checksum64   = 'ba76235158edd0788226e992ef495d59fb620e56b0833af34990091507c8b994'

function genLink($url) {
    $url = $url.Replace('http://www.fosshub.com', 'http://www.fosshub.com/genLink')
    $url.Replace('SMPlayer.html', 'SMPlayer')
}

if (Get-ProcessorBits 64) {
    $url = $url64; $checksum = $checksum64
} else {
    $url = $url32; $checksum = $checksum32
}

$url = genLink $url
$url = Get-UrlFromFosshub $url

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64bit               = $url
  checksum               = $checksum
  checksum64             = $checksum
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
