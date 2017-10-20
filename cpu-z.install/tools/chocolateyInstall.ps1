$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.81-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.81-en.exe'
  checksum       = '09c2327ffc2f065f67cae4e2d69a1efb8fcbb47ccc2c441a78936bd12f1fbe6b'
  checksum64     = '09c2327ffc2f065f67cae4e2d69a1efb8fcbb47ccc2c441a78936bd12f1fbe6b'
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
