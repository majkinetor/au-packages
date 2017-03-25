$ErrorActionPreference = 'Stop'

$packageName = 'eraser'
$url32       = 'https://sourceforge.net/projects/eraser/files/Eraser%206/6.2/Eraser%206.2.0.2979.exe'
$url64       = $url32
$checksum    = '090968D0D9C386924A2838C484855595890DA9879544C7D8B4B201F9756712C6'

$setupDir    = Get-PackageCacheLocation

$setupPath  = "$setupDir\eraser.exe"
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $setupPath
  url          = $url32
  url64bit     = $url64
  checksum     = $checksum
  checksumType = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

if (!(gcm 7z -ea 0)) {
    $path = gp HKCU:\Software\7-Zip Path | select -Expand Path
    if (!(Test-Path "$path\7z.exe")) { throw "Can not find 7z.exe" }
    sal 7z "$path\7z.exe"
}

cd $setupDir
7z x -aoa $setupPath -o*

$msi_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; ls "$setupDir\*eraser*x86*.msi" -Recurse | Select -Expand FullName
} else { Write-Host "Installing 32 bit version"; ls "$setupDir\*eraser*x64*.msi" -Recurse | Select -Expand FullName }


if (!(Test-Path $msi_path)) { throw "Unpacking failed" }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  file           = $msi_path
  silentArgs     = '/quiet'
  validExitCodes = @(0)
  softwareName   = "Eraser"
}
Install-ChocolateyInstallPackage @packageArgs
rm -force -r $setupDir\eraser\* -ea 0

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation) { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

