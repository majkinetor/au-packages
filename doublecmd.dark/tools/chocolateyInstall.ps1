$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = "$(Get-ToolsLocation)\doublecmd" }

$process = Get-Process doublecmd -ea 0
if ($process) {
  Write-Host "Stopping running doublecmd process"
  Stop-Process $process
  $process = $process.path
}

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath   = Get-Item $toolsPath\*.7z
    Destination    = Split-Path $pp.InstallDir
}

Write-Host "Installing to" $pp.InstallDir
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.7z -ErrorAction 0

Write-Host 'Setting system environment DCOMMANDER_PATH'
Set-EnvironmentVariable 'DCOMMANDER_PATH' $pp.InstallDir Machine

# Shortcut parameters
if (!$pp.NoDesktopIcon) {
    Write-Host "Creating desktop icon"
    $params = @{
      ShortcutFilePath = "$Env:Public\Desktop\Double Commander.lnk"
      TargetPath       = "$($pp.InstallDir)\doublecmd.exe"
      IconLocation     = "$($pp.InstallDir)\doublecmd.exe"
      Arguments        = "--no-splash"
  }
  Install-ChocolateyShortcut @params
}

if ($process) {
    Write-Host "Restarting doublecmd process"
    Start-Process $process
}
