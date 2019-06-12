$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = 'C:\influxdata' }

$packageArgs = @{
    PackageName    = 'influxdb'
    FileFullPath64 = gi $toolsPath\*.zip    
    Destination    = $pp.InstallDir
}

ls $toolsPath\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
