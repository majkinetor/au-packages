$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'dbeaver'
  softwareName   = 'dbeaver*'
  fileType       = 'exe'
  file           = gi "$toolsDir\*_x32.exe"
  file64         = gi "$toolsDir\*_x64.exe"
  silentArgs     = '/S /allusers'
  validExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsDir\*.exe -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
