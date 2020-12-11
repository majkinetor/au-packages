$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$process = Get-Process premotem -ea 0
if ($process) {
  Write-Host "Stopping running $Env:ChocolateyPackageName process"
  Stop-Process $process
  $process = $process.path
}

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = "$(Get-ToolsLocation)\PRemoteM" }

Write-Host "Installing to" $pp.InstallDir
New-Item -Type Directory $pp.InstallDir -ea 0 | Out-Null

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath   = Get-Item $toolsPath\*.7z
    Destination    = $pp.InstallDir
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

if ($process) {
    Write-Host "Restarting $Env:ChocolateyPackageName process"
    Start-Process $process
}
