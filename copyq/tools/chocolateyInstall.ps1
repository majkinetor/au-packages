$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$url         = 'https://github.com/hluk/CopyQ/releases/download/v2.6.0/copyq-2.6.0-setup.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) -ErrorAction SilentlyContinue | ? { $_.DisplayName -like "$packageName*" }
if ($key) {
    $installLocation = $key.InstallLocation
    if (Test-Path $installLocation)  {
        Write-Host "$packageName installed to '$installLocation'"
    }
}
