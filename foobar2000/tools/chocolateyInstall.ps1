$ErrorActionPreference = 'Stop'

$toolsPath     = Split-Path $MyInvocation.MyCommand.Definition
$installerPath = Get-Item $toolsPath\foobar2000_*.exe 

$packageArgs = @{
  packageName   = 'foobar2000'
  fileType      = 'exe' 
  file          = $installerPath
  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
rm $installerPath -ea 0; if (Test-Path $installerPath) { Set-Content "$installerPath.ignore" "" }

$pp = Get-PackageParameters
if (!$pp.NoShortcut ) {
    Write-Host "Removing desktop shortcut"
    $shortcutPath = Join-Path ([Environment]::GetFolderPath("CommonDesktopDirectory")) 'foobar2000.lnk'
    Remove-Item $shortcutPath -ea 0
}