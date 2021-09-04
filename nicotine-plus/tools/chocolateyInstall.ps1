$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'exe'
  file           = gi $toolsPath\windows-i686-installer\*.exe
  file64         = gi $toolsPath\windows-x86_64-installer\*.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Nicotine+ *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" }}

$packageName = 'Nicotine+'
$installLocation = Get-AppInstallLocation "$packageName*"
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe" -Name nicotine
Write-Host "$packageName registered as nicotine"
