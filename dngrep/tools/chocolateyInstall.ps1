$ErrorActionPreference = 'Stop'
$is64bit = Get-ProcessorBits -eq '64'

$packageName = 'dngrep'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x64.msi'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x86.msi'

$url         = $url64
if (!$is64bit) { $url = $url32 }

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'MSI'
  url                    = $url
  silentArgs             = '/quiet'
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
