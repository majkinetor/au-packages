$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.93-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.93-en.exe'
  checksum       = 'c446dfdf87ec0c077a46a9e75b4d50c68a178167b9bb4c7d0f3b32c8a4be59f6'
  checksum64     = 'c446dfdf87ec0c077a46a9e75b4d50c68a178167b9bb4c7d0f3b32c8a4be59f6'
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
