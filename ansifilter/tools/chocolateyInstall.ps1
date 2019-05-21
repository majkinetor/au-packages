$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'ansifilter'
    FileFullPath   = gi $toolsPath\*_x32.zip
    FileFullPath64 = gi $toolsPath\*_x64.zip    
    Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
