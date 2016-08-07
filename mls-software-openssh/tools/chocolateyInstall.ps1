$ErrorActionPreference = 'Stop'

$packageName = 'mls-software-openssh'
$url         = 'http://www.mls-software.com/files/setupssh-7.3p1-1.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64Bit               = $url
  silentArgs             = "/S"
  validExitCodes         = @(0)
  registryUninstallerKey = "OpenSSH"
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
