$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.82-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.82-en.exe'
  checksum       = 'c87a7ed16024e23e495caf69676994a7c5cd58fba0ea6bf278f98daaebc7ef2d'
  checksum64     = 'c87a7ed16024e23e495caf69676994a7c5cd58fba0ea6bf278f98daaebc7ef2d'
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
