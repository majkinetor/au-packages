$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'https://dbeaver.com/files/5.0.0/dbeaver-ee-5.0.0-x86-setup.exe'
$url64       = 'https://dbeaver.com/files/5.0.0/dbeaver-ee-5.0.0-x86_64-setup.exe'
$checksum32  = 'bdd18a54f38123562679912da3b8a5060e73ffa780f0612d60c3a20a0e80fbb7'
$checksum64  = '05da9b458a3c9a4895efb3152a18ab41fb989d547a5452f986e3ec066ef512f5'

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
