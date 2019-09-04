$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = Join-Path (Get-ToolsLocation) $Env:ChocolateyPackageName }

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath   = gi $toolsPath\*.zip
    Destination    = $pp.InstallDir
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

$exePath = Join-Path $pp.InstallDir musikcube.exe

Register-Application $exePath
Register-Application $exePath mcube
Write-Host "Application registered as musikcube and mcube"

Install-BinFile musikcube $exePath
Install-BinFile mcube $exePath

