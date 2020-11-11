$ErrorActionPreference = 'Stop'

$packageName = 'eac'
$url32       = 'http://www.exactaudiocopy.de/eac-1.6.exe'
$checksum32  = '8291d33104ebab2619ba8d85744083e241330a286f5bd7d54c7b0eb08f2b84c1'

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
