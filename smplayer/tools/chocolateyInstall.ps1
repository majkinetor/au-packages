$ErrorActionPreference = 'Stop'

$packageName  = 'smplayer'
$url32        = 'http://www.fosshub.com/SMPlayer.html/smplayer-16.4.0-win32.exe'
$url64        = 'http://www.fosshub.com/SMPlayer.html/smplayer-16.4.0-x64.exe'

function genLink($url) {
    $url = $url.Replace('http://www.fosshub.com', 'http://www.fosshub.com/genLink')
    $url.Replace('SMPlayer.html', 'SMPlayer')
}

$url = if (Get-ProcessorBits -eq 64) { $url64 } else { $url32}
$url = genlink $url
$url = (new-object net.webclient).DownloadString( $url )

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

$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) -ErrorAction SilentlyContinue | ? { $_.DisplayName -like "$($packageArgs.registryUninstallerKey)*" }
if ($key) {
    $installLocation = Split-Path $key.DisplayIcon
    if (Test-Path $installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
}
