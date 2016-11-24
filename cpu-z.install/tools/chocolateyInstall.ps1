$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.78-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.78-en.exe'
  checksum       = '2189805a0ec65d3daaa96f70eefac7fac7cb677dacb5a947e08c8fe9c5e08c6d'
  checksum64     = '2189805a0ec65d3daaa96f70eefac7fac7cb677dacb5a947e08c8fe9c5e08c6d'
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
