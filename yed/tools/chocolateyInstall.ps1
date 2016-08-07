$ErrorActionPreference = 'Stop'

$packageName = 'yed'
$url         = 'https://www.yworks.com/resources/yed/demo/yEd-3.16.1.zip'
$checksum    = 'F2C48697AE2D6D1FA29005157D3D8F319380BEF9ECC250AE727246BD2F9BFE40'
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
