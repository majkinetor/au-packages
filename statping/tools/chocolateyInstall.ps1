$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = 'C:\statping' }

Write-Host "Installing to" $pp.InstallDir
mkdir $pp.InstallDir -ea 0 | Out-Null
mv -Force $toolsDir\statping* $pp.InstallDir 

if ($pp.ContainsKey('Service')) { Install-Service "$($pp.InstallDir)\statping.exe" }