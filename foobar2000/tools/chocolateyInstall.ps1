$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$installerPath = Get-Item $toolsPath\foobar2000_*.exe
$pp = Get-PackageParameters

$silentArgs = @( '/S' )
if ($pp.InstallDir) { $silentArgs += "/D={0}" -f $pp.InstallDir }

$packageArgs = @{
  packageName   = $Env:ChocolateyPackageName
  fileType      = 'exe'
  file          = $installerPath
  silentArgs    = $silentArgs
  validExitCodes= @(0)
}
Install-ChocolateyInstallPackage @packageArgs
rm $installerPath -ea 0; if (Test-Path $installerPath) { Set-Content "$installerPath.ignore" "" }

if (!$pp.InstallDir) {
  $installLocation = Get-AppInstallLocation $Env:ChocolateyPackageName
  if (!$installLocation)  { Write-Warning "Can't find $Env:ChocolateyPackageName install location"; return }
  $pp.InstallDir = $installLocation
}
Write-Host "Installed to" $pp.InstallDir

if ($pp.NoShortcut) {
    Write-Host "Removing desktop shortcut"
    $shortcutPath = Join-Path ([Environment]::GetFolderPath("CommonDesktopDirectory")) 'foobar2000.lnk'
    Remove-Item $shortcutPath -ea 0
}

if ($pp.Portable) {
    Write-Host "Making installation portable"
    $f = Join-Path $pp.InstallDir portable_mode_enabled
    Out-File $f
}
