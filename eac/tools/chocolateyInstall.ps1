$ErrorActionPreference = 'Stop'

$packageName = 'eac'
$url32       = 'http://www.exactaudiocopy.de/eac-1.1.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = "Exact Audio Copy"
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
