$ErrorActionPreference = 'Stop'

$packageName = 'mls-software-openssh'
$url         = 'https://www.mls-software.com/files/setupssh-8.9p1-1.exe'
$checksum    = '4f36fe3ed7edf0d10e5c2e1676c12e729badafe76fdd7b4473532a9f1d534f90'

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
