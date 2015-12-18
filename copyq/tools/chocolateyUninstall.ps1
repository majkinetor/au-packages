$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$fileType    = 'exe'
$silentArgs  = '/VERYSILENT'

$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) -ErrorAction SilentlyContinue | ? { $_.DisplayName -like "$packageName*" }
if ($key) {
    $uninstallString = $key.UninstallString
    Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $uninstallString
}
