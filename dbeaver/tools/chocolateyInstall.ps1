$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'dbeaver'
  fileType       = 'exe'
  file64         = gi $toolsPath\*.exe
  silentArgs     = '/S /allusers'
  validExitCodes = @(0)
  softwareName   = 'DBeaver *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" "" }}

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find install location"; return }
Write-Host "Installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
