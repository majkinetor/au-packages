$ErrorActionPreference = 'Stop'

$packageName = 'taskinfo'
$url32       = 'http://www.iarsn.com/taskinfo/tskinf10_0.exe'
$url64       = 'http://www.iarsn.com/taskinfo/tskinf10_0.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

if ($Env:ChocolateyPackageParameters -eq '/Register') {
    Write-Host "Registering for private non-commerical use."
    sp HKCU:\SOFTWARE\Iarsn\TaskInfo_10_0\Registration\Current PersonalUse 1
}

$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) -ErrorAction SilentlyContinue | ? { $_.DisplayName -like "$($packageArgs.registryUninstallerKey)*" }
if ($key) {
    $installLocation = $key.InstallLocation
    if (Test-Path $installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
}
