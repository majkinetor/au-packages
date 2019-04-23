$ErrorActionPreference = 'Stop'

$packageName = 'mls-software-openssh'
$url         = 'https://www.mls-software.com/files/setupssh-8.0p1-2.exe'
$checksum    = 'b86a49c646e611b2cec954ff536682103e14a260d6dd191290f90d7a106cb7a9'

$pp = Get-PackageParameters
$params = @()
foreach ($key in $pp.Keys) {
    $params += "/{0}={1}" -f $key, $pp[$key]
}
$params = $params -join ' '
Write-Host "Passed parameters: $params"

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64Bit               = $url
  checksum               = $checksum
  checksum64             = $checksum
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/S $params"
  validExitCodes         = @(0)
  registryUninstallerKey = "OpenSSH"
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
