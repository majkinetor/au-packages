$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.86-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.86-en.exe'
  checksum       = '5ee78d4a8d7ec79584ad313e203ad27b5004ededa5fb110ea396475b87afcb62'
  checksum64     = '5ee78d4a8d7ec79584ad313e203ad27b5004ededa5fb110ea396475b87afcb62'
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
