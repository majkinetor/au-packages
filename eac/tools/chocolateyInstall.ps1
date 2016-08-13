$ErrorActionPreference = 'Stop'

$packageName = 'eac'
$url32       = 'http://www.exactaudiocopy.de/eac-1.2.exe'
$checksum32  = '88B8AC9F61B08DB4B223B168EB4A310E4EA43B4D36ED20F0AAC48BF034F8D448'

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
