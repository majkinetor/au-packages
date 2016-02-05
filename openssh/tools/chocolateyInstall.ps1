$ErrorActionPreference = 'Stop'

$packageName = 'openssh'
$url         = 'http://www.mls-software.com/files/setupssh-7.1p2-1.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64Bit               = $url
  silentArgs             = "/S"
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) -ErrorAction SilentlyContinue | ? { $_.DisplayName -like "$packageName*" }
if ($key) {
    $installLocation = Split-Path $key.UninstallString
    if (Test-Path $installLocation)  {
        Write-Host "$packageName installed to '$installLocation'"
    }
}
