$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName  = 'solr'
    FileFullPath = gi $toolsPath\*.zip  
    Destination  = Get-ToolsLocation
}

Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0