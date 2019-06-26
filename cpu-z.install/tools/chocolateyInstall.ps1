$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.89-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.89-en.exe'
  checksum       = 'e16dc277eab7cdb69a4974ae3f6d5eba514ca58fc5157cedf0add2d1e416cd2e'
  checksum64     = 'e16dc277eab7cdb69a4974ae3f6d5eba514ca58fc5157cedf0add2d1e416cd2e'
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
