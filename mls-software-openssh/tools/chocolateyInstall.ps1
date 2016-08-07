$ErrorActionPreference = 'Stop'

$packageName = 'mls-software-openssh'
$url         = 'http://www.mls-software.com/files/setupssh-7.3p1-1.exe'
$checksum    = 'F4448072A09EBF780C0FA217FBF595531357378F94287E888986BD270F9AC7C9'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64Bit               = $url
  checksum               = $checksum
  checksum64             = $checksum
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/S"
  validExitCodes         = @(0)
  registryUninstallerKey = "OpenSSH"
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
