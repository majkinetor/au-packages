$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$fileType    = 'exe'
$silentArgs  = '/VERYSILENT'

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

if ($is64bit) { $key = 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' }
else          { $key = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall' }

$reg = ls $key | ? { (gp $_.PSPath DisplayName -ea ig) -match $packageName }
$uninstallString = $reg.GetValue("UninstallString")
Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $UninstallString
