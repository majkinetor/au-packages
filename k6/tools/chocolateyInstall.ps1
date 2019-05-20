$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'k6'
    FileFullPath   = gi $toolsPath\*win32.zip
    FileFullPath64 = gi $toolsPath\*win64.zip
    Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
