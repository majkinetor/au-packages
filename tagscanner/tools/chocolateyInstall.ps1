$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tagscanner'
  fileType       = 'exe'
  file           = "$toolsPath\tagscan-6.1.11-setup.exe"
  file64         = "$toolsPath\tagscan-6.1.11_x64-setup.exe"
  silentArgs    = "/VERYSILENT /NORESTART /SP- /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS"
  validExitCodes = @(0)
  softwareName   = 'TagScanner *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation "$packageName*"
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\Tagscan.exe"
Write-Host "$packageName registered as Tagscan"
