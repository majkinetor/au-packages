$ErrorActionPreference = 'Stop'

$packageName = 'eac'
$url32       = 'http://www.exactaudiocopy.de/eac-1.1.exe'
$checksum32  = '25184ACB27EB113E57B2994424383DD141B77F7A1C3C07B779D3821FD6BE412D'

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
