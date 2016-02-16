$ErrorActionPreference = 'Stop'

$packageName = 'yed'
$url         = 'https://www.yworks.com/resources/yed/demo/yEd-3.14.4.zip'
$toolsDir    = Split-Path $MyInvocation.MyCommand.Definition
$cmdPath     = join-path $env:ChocolateyInstall $env:chocolatey_bin_root\yed.cmd

$packageArgs = @{
  packageName   = $packageName
  url           = $url
  url64bit      = $url
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs

$yedDir = (gi $toolsDir\yed-*).FullName
"start javaw -jar ""$yedDir\yed.jar""" | out-file $cmdPath -Encoding ascii

if ($Env:ChocolateyPackageParameters -eq '/Shortcut') {
    Write-Host "Creating desktop shortcut"
    Install-ChocolateyShortcut -shortcutFilePath "$env:USERPROFILE\Desktop\yed.lnk" -targetPath $cmdPath -IconLocation $yedDir\icons\yicon.ico
}

Write-Host "Yed installed in: $yedDir"
Write-Host "Yed added to chocolatey bin directory"
