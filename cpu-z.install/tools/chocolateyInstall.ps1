$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'cpu-z.install'
  fileType       = 'exe'
  url            = 'http://download.cpuid.com/cpu-z/cpu-z_1.79-en.exe'
  url64bit       = 'http://download.cpuid.com/cpu-z/cpu-z_1.79-en.exe'
  checksum       = 'bc93cc73cfa7a9ec02e68d022616b412e68fe745a543af5709c07b9da314f379'
  checksum64     = 'bc93cc73cfa7a9ec02e68d022616b412e68fe745a543af5709c07b9da314f379'
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
