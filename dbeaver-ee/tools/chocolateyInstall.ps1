$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/6.1.0/dbeaver-ee-6.1.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/6.1.0/dbeaver-ee-6.1.0-x86_64-setup.exe'
$checksum32  = 'd1e02d09d3b13bad7fe1c6de476d115eaf7536a6fa10c7ec3188440a1ac00530'
$checksum64  = '248ce47503e2826bd719b2c8bc3dd06a727026537f909cd1b85e9bcc94f0f109'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S /allusers'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
