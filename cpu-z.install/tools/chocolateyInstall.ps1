$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.79-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.79-en.exe'
  checksum       = '47fcb949efc837ef26e28553b10f525b9af52e0ff954eae72a8f4ca2070b440d'
  checksum64     = '47fcb949efc837ef26e28553b10f525b9af52e0ff954eae72a8f4ca2070b440d'
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
