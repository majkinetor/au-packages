$packageName = 'copyq'
$programName = 'copyq'
$fileType    = 'exe'
$silentArgs  = '/VERYSILENT'

$key = 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
$reg = ls $key | ? { (gp $_.PSPath DisplayName -ea ig) -match $programName}
$uninstallString = $reg.GetValue("UninstallString")
Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $UninstallString
