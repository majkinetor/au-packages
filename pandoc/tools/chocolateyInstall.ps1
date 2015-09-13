$ErrorActionPreference = 'Stop'

$packageName = 'pandoc'
$url         = 'https://github.com/jgm/pandoc/releases/download/1.15.0.6/pandoc-1.15.0.6-windows.msi'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'msi'
  url                    = $url
  silentArgs             = '/quiet'
}
Install-ChocolateyPackage @packageArgs


$is64bit = Get-ProcessorBits -eq 64

$key = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall'
$reg = ls $key | ? { (gp $_.PSPath DisplayName -ea ig) -match $packageName}
if (!$reg) { return }

$installLocation = $reg.GetValue("InstallLocation")
"Installed location: $installLocation"

#if (Test-Path $installLocation)  {
    #Write-Host "$packageName installed to $installLocation"
    #Install-ChocolateyPath $installLocation
#}

