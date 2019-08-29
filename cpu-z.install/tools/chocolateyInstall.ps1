$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.90-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.90-en.exe'
  checksum       = 'fd989ca4f0e15ff326711463f64d4e39e4f7e76ce8455472b5a2504757e849ce'
  checksum64     = 'fd989ca4f0e15ff326711463f64d4e39e4f7e76ce8455472b5a2504757e849ce'
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
