$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$is64      = (Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true'
$setupDir  = Get-PackageCacheLocation

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName 
    FileFullPath   = gi $toolsPath\*.exe
    FileFullPath64 = gi $toolsPath\*.exe    
    Destination    = $setupDir
}
Get-ChocolateyUnzip @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" "" }}


$msi_glob = if ($is64) { "*eraser*x64*.msi" } else { "*eraser*x86*.msi"}
$msi_path = ls "$setupDir\$msi_glob" -Recurse | select -Expand FullName
if (!(Test-Path $msi_path)) { throw "Unpacking failed" }

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName 
  fileType       = 'msi'
  file           = $msi_path
  silentArgs     = '/quiet'
  validExitCodes = @(0)
  softwareName   = "Eraser"
}
Install-ChocolateyInstallPackage @packageArgs
rm -force -r $setupDir\eraser\* -ea 0

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation) { Write-Warning "Can't find install location"; return }
Write-Host "Installed to '$installLocation'"

