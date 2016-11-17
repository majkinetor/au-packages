$ErrorActionPreference = 'Stop'

$url32 = Get-UrlFromFosshub 'https://www.fosshub.com/SMPlayer.html/smplayer-16.11.0-win32.exe'
$url64 = Get-UrlFromFosshub 'https://www.fosshub.com/SMPlayer.html/smplayer-16.11.0-x64.exe'

$packageArgs = @{
  packageName            = 'smplayer'
  fileType               = 'exe'
  url                    = $url32
  url64bit               = $url64
  checksum               = '3fff91ed669acd737cc7d079bd30944a3d739fa1cd9cb526c7a87c9518016850'
  checksum64             = '45332f2e784544de10ee156e3d42e7d0468f9321763c924e7aae497f854b59be'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'smplayer*'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "Registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
