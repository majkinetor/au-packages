$ErrorActionPreference = 'Stop'

$packageName  = 'smplayer'
$url32        = 'https://www.fosshub.com/SMPlayer.html/smplayer-16.11.0-win32.exe'
$url64        = 'https://www.fosshub.com/SMPlayer.html/smplayer-16.11.0-x64.exe'
$checksum32   = '3fff91ed669acd737cc7d079bd30944a3d739fa1cd9cb526c7a87c9518016850'
$checksum64   = '45332f2e784544de10ee156e3d42e7d0468f9321763c924e7aae497f854b59be'

$webClient = New-Object System.Net.WebClient
$url = if ((Get-ProcessorBits 32) -or ($Env:chocolateyForceX86 -eq 'true')) { $url32 } else { $url64 }
$url = $webClient.DownloadString($url)
$url -match '<iframe [^>]+ src="(.+)?">' | Out-Null
$url = $Matches[1]

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64bit               = $url
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
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "Registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
