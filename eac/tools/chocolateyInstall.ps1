$ErrorActionPreference = 'Stop'

$packageName = 'eac'
$url32       = 'http://www.exactaudiocopy.de/eac-1.4.exe'
$checksum32  = 'aa3d6852e20f58a0eff5bff321a6bd93f1f59ead91d98e21344be07bd942665a'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  checksum               = $checksum32
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = "Exact Audio Copy"
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
