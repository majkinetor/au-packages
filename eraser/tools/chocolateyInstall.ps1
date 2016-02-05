$ErrorActionPreference = 'Stop'

$setupDir    = "$Env:TEMP\eraser_setup"
$packageName = 'eraser'
$url         = 'http://netcologne.dl.sourceforge.net/project/eraser/Eraser%206/6.2/Eraser6.2.0.2971-NoRuntimes.exe'

$setupPath  = $setupDir + ".exe"
Get-ChocolateyWebFile $packageName $setupPath $url $url

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
  registryUninstallerKey = "Exact Audio Copy"
}
Install-ChocolateyPackage @packageArgs
rm -force -r $setupDir -ea 0
rm $setupPath -ea 0
