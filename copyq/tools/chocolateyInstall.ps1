$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$running     = if (ps $packageName -ea 0) { $true } else { $false }

$fileType      = ''
$toolsDir      = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = gi "$toolsDir\*.$fileType"

$packageArgs = @{
  packageName    = $packageName
  fileType       = $fileType
  file           = $embedded_path
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
  softwareName   = $packageName
}
Install-ChocolateyInstallPackage @packageArgs
rm $embedded_path -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"

Write-Host "CopyQ was running before update, starting it up again"
start "$installLocation\$packageName.exe"
