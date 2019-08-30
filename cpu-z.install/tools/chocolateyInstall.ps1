$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.90-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.90-en.exe'
  checksum       = 'f6882adb8a399ddd3e5c4769b1b8d30994caba1b4a32d2c3fd195b946453fb23'
  checksum64     = 'f6882adb8a399ddd3e5c4769b1b8d30994caba1b4a32d2c3fd195b946453fb23'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
  softwareName   = 'cpu-z'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\cpuz.exe"
    Write-Host "$packageName registered as cpuz"
}
else { Write-Warning "Can't find $packageName install location" }
