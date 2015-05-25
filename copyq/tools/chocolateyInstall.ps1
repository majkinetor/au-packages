$packageName    = 'copyq'
$installerType  = 'exe'
$url            = 'https://github.com/hluk/CopyQ/releases/download/v2.4.6/copyq-2.4.6-setup.exe' # download url
$silentArgs     = '/VERYSILENT'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes

$key = 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
$reg = ls $key | ? { (gp $_.PSPath DisplayName -ea ig) -match 'copyq'}
$installLocation = $reg.GetValue("InstallLocation")
if (Test-Path $installLocation)  { Install-ChocolateyPath $installLocation }

