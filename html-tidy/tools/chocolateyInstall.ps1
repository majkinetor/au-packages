$ErrorActionPreference = 'Stop'

$packageName = 'html-tidy'
$url32       = 'https://github.com/htacg/tidy-html5/releases/download/5.1.25/tidy-5.1.25-win32.zip'
$url64       = 'https://github.com/htacg/tidy-html5/releases/download/5.1.25/tidy-5.1.25-win64.zip'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) -ErrorAction SilentlyContinue | ? { $_.DisplayName -like "$($packageArgs.registryUninstallerKey)*" }
if ($key) {
    $installLocation = $key.InstallLocation
    if (Test-Path $installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
}
