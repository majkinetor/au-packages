$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/4.1.1/dbeaver-ee-4.1.1-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/4.1.1/dbeaver-ee-4.1.1-x86_64-setup.exe'
$checksum32  = '3e5004df8ef74666a20f5b88abe0e74a16d9af2613010f5cd7c60338c60e20ee'
$checksum64  = '47b49faa133c498d9c601a21edde276c68a2e174f1e7a732372e0a5602acd3b5'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
