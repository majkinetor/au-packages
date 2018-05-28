$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

if (!($Env:COMMANDER_PATH -and (Test-Path $Env:COMMANDER_PATH))) { throw 'This package requires COMMANDER_PATH environment variable set' }

$packageArgs = @{
    PackageName    = 'tcp-qse'
    FileFullPath   = gi $toolsPath\*.zip
    Destination    = $Env:COMMANDER_PATH
}

Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
