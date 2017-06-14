$ErrorActionPreference = 'Stop'

if (!($Env:RDECK_BASE -and (Test-Path $Env:RDECK_BASE)) { throw "RDECK_BASE environment variable is invalid" }

if (Get-Service rundeck -ea 0) { Stop-Service rundeck }

rm $Env:RDECK_BASE\server\exp -Recurse -Force
rm $Env:RDECK_BASE\server\lib -Recurse -Force