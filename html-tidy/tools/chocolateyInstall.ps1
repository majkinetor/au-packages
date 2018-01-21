$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'html-tidy'
    FileFullPath   = gi $toolsPath\*-32b.zip
    FileFullPath64 = gi $toolsPath\*-64b.zip
    Destination    = $toolsPath
}
ls $toolsPath\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
