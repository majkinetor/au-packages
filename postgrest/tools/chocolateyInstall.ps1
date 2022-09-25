$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = 'C:\postgrest' }

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath64 = gi $toolsPath\*.zip
    Destination    = $pp.InstallDir
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

$pgr = Get-ChildItem -Recurse "$($pp.InstallDir)/*/*" -Filter postgrest.exe
if ($pgr) { Move-Item $pgr $pp.InstallDir -Force }
