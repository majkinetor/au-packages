$ErrorActionPreference = 'Stop'

$packageName = 'yed'
$url         = 'https://www.yworks.com/resources/yed/demo/yEd-3.16.2.zip'
$checksum    = 'd25432c7fa1e3d19d700e829e087c6ab32b0d7f23a1c367f6ea12a0e63363b0e'
$toolsDir    = Split-Path $MyInvocation.MyCommand.Definition
$cmdPath     = join-path $env:ChocolateyInstall bin\yed.cmd

$packageArgs = @{
  packageName    = $packageName
  url            = $url
  url64bit       = $url
  checksum       = $checksum
  checksum64     = $checksum
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs

$yedDir = gi $toolsDir\yed-* | sort creationtime -Descending | select -First 1 -Expand Fullname
"start javaw -jar ""$yedDir\yed.jar"" %1" | out-file $cmdPath -Encoding ascii

if ($Env:ChocolateyPackageParameters -eq '/Shortcut') {
    Write-Host "Creating desktop shortcut"
    Install-ChocolateyShortcut -shortcutFilePath "$env:USERPROFILE\Desktop\yed.lnk" -targetPath $cmdPath -IconLocation $yedDir\icons\yicon.ico
}

Write-Host "Yed installed in: $yedDir"
Write-Host "yed.cmd added to chocolatey bin directory"
