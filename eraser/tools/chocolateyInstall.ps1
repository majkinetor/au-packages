$ErrorActionPreference = 'Stop'

$setupDir    = "$Env:TEMP\eraser_setup"
$packageName = 'eraser'
$url32       = 'http://netcologne.dl.sourceforge.net/project/eraser/Eraser%206/6.2/Eraser6.2.0.2971-NoRuntimes.exe'
$url64       = $url32
$checksum    = '3851189937D5D347D240A9C3703FE9F7BBC792EDCBDDD8ED08F34EE7D183C062'

$setupPath  = $setupDir + ".exe"
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
    gp HKCU:\Software\7-Zip Path | select -Expand Path | set path
    if (!(Test-Path "$path\7z.exe")) { throw "Can not find 7z.exe" }
    sal 7z "$path\7z.exe"
}

cd $Env:TEMP
7z x -aoa $setupPath -o*

$url32 = gi "$setupDir\*86*" | Select -Expand FullName
$url64 = gi "$setupDir\*64*" | Select -Expand FullName
if (((Test-Path $url32,$url64) -eq $false).Count) { throw "Unpacking failed" }

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'msi'
  url                    = $url32
  url64bit               = $url64
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  registryUninstallerKey = "Eraser"
}
Install-ChocolateyPackage @packageArgs
rm -force -r $setupDir -ea 0
rm $setupPath -ea 0

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

