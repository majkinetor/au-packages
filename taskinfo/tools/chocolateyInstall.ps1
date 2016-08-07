$ErrorActionPreference = 'Stop'

$packageName = 'taskinfo'
$url         = 'http://www.iarsn.com/taskinfo/tskinf10_0.exe'
$checksum    = '0D2717ABB312F758B1F23FB4FA3E79535D6315E1D5CD3C0C804C10DAB12A1212'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64bit               = $url
  checksum               = $checksum
  checksum64             = $checksum
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

if ($Env:ChocolateyPackageParameters -eq '/Register') {
    Write-Host "Registering for private non-commerical use."
    sp HKCU:\SOFTWARE\Iarsn\TaskInfo_10_0\Registration\Current PersonalUse 1
}

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
