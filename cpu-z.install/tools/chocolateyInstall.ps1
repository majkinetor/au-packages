$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.89-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.89-en.exe'
  checksum       = '4596c4fdbe65d3f4467be1c22cbbeca410bb065ec762d85b42c8484145b4f0e4'
  checksum64     = '4596c4fdbe65d3f4467be1c22cbbeca410bb065ec762d85b42c8484145b4f0e4'
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
