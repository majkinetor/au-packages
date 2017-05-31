$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.79-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.79-en.exe'
  checksum       = '170adb03d00ac93dec154bbc2ef925a74f8ff96cfdb7e8c0728dbc6376bc560e'
  checksum64     = '170adb03d00ac93dec154bbc2ef925a74f8ff96cfdb7e8c0728dbc6376bc560e'
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
