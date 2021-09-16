$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'msi'
  file64         = gi $toolsPath\*.msi
  silentArgs     = '/q'
  validExitCodes = @(0)
  softwareName   = 'Flameshot *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.msi | % { rm $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation "$packageName*"
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\bin\$packageName.exe"
Write-Host "$packageName registered as $packageName"
