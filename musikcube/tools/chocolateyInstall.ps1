$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = Join-Path (Get-ToolsLocation) musikcube }

$packageArgs = @{
    PackageName    = 'musikcube'
    FileFullPath   = gi $toolsPath\*.zip
    Destination    = $pp.InstallDir
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

Register-Application (Join-Path $pp.InstallDir musikcube.exe) mcube
Write-Host "Application registered as mcube"
