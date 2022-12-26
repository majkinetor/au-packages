$ErrorActionPreference = 'Stop'

$packageName = 'mls-software-openssh'
$url         = 'https://www.mls-software.com/files/setupssh-9.1p1-1.exe'
$checksum    = 'a1ad16ff2b1bed5a8280b043c98f2dc308dbb4456a39f98f722ee4b14d3df5de'

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
