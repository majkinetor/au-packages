$ErrorActionPreference = 'Stop'

$packageName = 'mls-software-openssh'
$url         = 'http://www.mls-software.com/files/setupssh-7.3p1-2.exe'
$checksum    = '8a2a06914ad0767306f17c3625ed59a5f480ace323091213b1ffe25c232e35f3'

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
