$ErrorActionPreference = 'Stop'

if (!($Env:RDECK_BASE -and (Test-Path $Env:RDECK_BASE)) { throw "RDECK_BASE environment variable is invalid" }

if (Get-Service rundeck -ea 0) { Stop-Service rundeck }

Write-Host "Removing 'exp' and 'lib' folders from '$Env:RDECK_BASE\server'"
cd $Env:RDECK_BASE\server
rm exp,lib -Recurse -Force