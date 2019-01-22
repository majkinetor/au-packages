$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/5.3.3/dbeaver-ee-5.3.3-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/5.3.3/dbeaver-ee-5.3.3-x86_64-setup.exe'
$checksum32  = '8976696e02e4337e5c3bcc0e618571783f6b2312fbc8730bbdd2505603fffa89'
$checksum64  = 'b68467210db785afb9da67c09bd091e0890b64f3a40f24d8457ced718dc0178c'

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
