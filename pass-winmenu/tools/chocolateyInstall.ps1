$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$installDir = if ($pp.InstallDir ) { $pp.InstallDir } else { Join-Path (Get-ToolsLocation) $Env:ChocolateyPackageName }
Write-Host "Sysinternals Suite is going to be installed in '$installDir'"

$packageArgs = @{
    PackageName    = 'pass-winmenu'
    FileFullPath   = gi $toolsPath\*.zip
    Destination    = $installDir
}

Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
