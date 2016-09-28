$ErrorActionPreference = 'Stop'

$packageName  = 'smplayer'
$url32        = 'https://www.fosshub.com/SMPlayer.html/smplayer-16.9.0-win32.exe'
$url64        = 'https://www.fosshub.com/SMPlayer.html/smplayer-16.9.0-x64.exe'
$checksum32   = 'a7dd43d91712c8db1febc56809bcf0537a85e5839eb9e73ee018c772b851bc8a'
$checksum64   = '394260c807956dab59fdf807915a7c6f5385a20f61ab107b58a0a5bf19ad58de'

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
