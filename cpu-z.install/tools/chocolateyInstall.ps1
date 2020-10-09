$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.94-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.94-en.exe'
  checksum       = 'ad9cf4cfe30a4cd51f675aa8ed7810258decf0247a53eb3c44f241a1671617d8'
  checksum64     = 'ad9cf4cfe30a4cd51f675aa8ed7810258decf0247a53eb3c44f241a1671617d8'
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
