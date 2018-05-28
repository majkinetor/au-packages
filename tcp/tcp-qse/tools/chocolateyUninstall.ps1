$ErrorActionPreference = 'Stop'

if (!($Env:COMMANDER_PATH -and (Test-Path $Env:COMMANDER_PATH))) { throw 'This package requires COMMANDER_PATH environment variable set' }

Write-Host "Removing TotalCmd plugin files: QuickSearch Extended"
ls $Env:COMMANDER_PATH\tcmatch* | rm