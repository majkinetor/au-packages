$ErrorActionPreference = 'Stop'

$packageName = 'pandoc'
$url         = 'https://github.com/jgm/pandoc/releases/download/1.17.0.2/pandoc-1.17.0.2-windows.msi'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'msi'
  url                    = $url
  silentArgs             = '/quiet'
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
    Write-Host "Adding $packageName to the PATH if needed"
    Install-ChocolateyPath $installLocation "Machine"
}

