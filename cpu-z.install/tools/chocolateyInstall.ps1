$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.90-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.90-en.exe'
  checksum       = 'cae31d06cef8f2f2ad988b6bddbdca154733b1a2226f9b59faf609f9e09a1db5'
  checksum64     = 'cae31d06cef8f2f2ad988b6bddbdca154733b1a2226f9b59faf609f9e09a1db5'
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
