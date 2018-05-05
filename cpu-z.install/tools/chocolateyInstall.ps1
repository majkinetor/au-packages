$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.85-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.85-en.exe'
  checksum       = '8b2188e6c9c87ff32f99df33005c2f1d2f0faf766615efc69de9c0f9dddb2f3d'
  checksum64     = '8b2188e6c9c87ff32f99df33005c2f1d2f0faf766615efc69de9c0f9dddb2f3d'
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
