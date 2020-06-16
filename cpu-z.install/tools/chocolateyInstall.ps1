$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.92-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.92-en.exe'
  checksum       = '46ee9bd10751f8609d0e23c2ddfc4ead04808c25698056529e268c8c1da24243'
  checksum64     = '46ee9bd10751f8609d0e23c2ddfc4ead04808c25698056529e268c8c1da24243'
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
