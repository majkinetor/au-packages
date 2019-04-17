$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.88-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.88-en.exe'
  checksum       = '078f4458e396d85cbc6f737a4bacc9a90734a5e3199cbdfe8100f6d68f1f0104'
  checksum64     = '078f4458e396d85cbc6f737a4bacc9a90734a5e3199cbdfe8100f6d68f1f0104'
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
