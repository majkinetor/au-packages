$ErrorActionPreference = 'Stop'

$toolsPath  = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath64 = Get-Item $toolsPath\*.zip
    Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
