$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = ''
  fileType               = 'EXE'
  url                    = ''
  url64bit               = ''
  checksum               = ''
  checksum64             = ''
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = ''
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
