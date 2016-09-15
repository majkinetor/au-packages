$ErrorActionPreference = 'Stop'

$packageName = 'cpu-z.install'
$url32       = 'http://download.cpuid.com/cpu-z/cpu-z_1.77-en.exe'
$url64       = $url32
$checksum32  = '418b0916726e31c8e3aa598ceb1f0549ed6261609e19018297ec1c38ca0fdeb8'
$checksum64  = $checksum32

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  registryUninstallerKey = 'cpu-z'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\cpuz.exe"
    Write-Host "$packageName registered as cpuz"
}
else { Write-Warning "Can't find $PackageName install location" }
