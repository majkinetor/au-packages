$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
if (!$pp.InstallRoot) { $pp.InstallRoot = 'C:\influxdata' }

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath64 = gi $toolsPath\*.zip
    Destination    = $pp.InstallRoot
}

ls $toolsPath\*.zip | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

if ($pp.Service) { Install-InfluxDbService -ServiceName influxdb2 }
