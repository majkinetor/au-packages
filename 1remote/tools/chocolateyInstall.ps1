$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$process = Get-Process 1remote -ea 0
if ($process) {
  Write-Host "Stopping running $Env:ChocolateyPackageName process"
  Stop-Process $process
  $process = $process.path
  Start-Sleep 5
}

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = "$(Get-ToolsLocation)\1Remote" }

Write-Host "Installing to" $pp.InstallDir
New-Item -Type Directory $pp.InstallDir -ea 0 | Out-Null

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath   = Get-Item $toolsPath\*.zip
    Destination    = $pp.InstallDir
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

if (!$pp.NoDesktopIcon) {
    Write-Host "Creating desktop icon"
    $params = @{
      ShortcutFilePath = "$Env:Public\Desktop\1Remote.lnk"
      TargetPath       = "$($pp.InstallDir)\1Remote.exe"
      IconLocation     = "$($pp.InstallDir)\1Remote.exe"
      WorkingDirectory = $pp.InstallDir
  }
  Install-ChocolateyShortcut @params
}

if ($process) {
    Write-Host "Restarting $Env:ChocolateyPackageName process"
    Start-Process $process -WorkingDirectory $pp.InstallDir
}
