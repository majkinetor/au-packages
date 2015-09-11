$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$url         = 'https://github.com/hluk/CopyQ/releases/download/v2.4.9/copyq-2.4.9-setup.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
}
Install-ChocolateyPackage @packageArgs


$processor = Get-WmiObject Win32_Processor
$is64bit   = $processor.AddressWidth -eq 64
if ($is64bit) { $key = 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' }
else          { $key = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall' }
$reg = ls $key | ? { (gp $_.PSPath DisplayName -ea ig) -match $packageName}
if (!$reg) { return }

$installLocation = $reg.GetValue("InstallLocation")
if (Test-Path $installLocation)  {
    Write-Host "$packageName installed to $installLocation"
    Install-ChocolateyPath $installLocation
}

