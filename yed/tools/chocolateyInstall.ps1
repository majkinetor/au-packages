$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$packageArgs = @{
  packageName    = 'yed'
  url            = 'https://www.yworks.com/resources/yed/demo/yEd-3.16.2.1.zip'
  url64bit       = 'https://www.yworks.com/resources/yed/demo/yEd-3.16.2.1.zip'
  checksum       = '47ac746ad30eb6375b8f45e9382efd0db0b6e3b1eb8f4760625963175b753805'
  checksum64     = '47ac746ad30eb6375b8f45e9382efd0db0b6e3b1eb8f4760625963175b753805'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
$yedDir = gi $toolsDir\yed-*
mv $yedDir\* $toolsDir
rm $yedDir

$cmdPath = "$toolsDir\yed.cmd"
"start javaw -jar $toolsDir\yed.jar" | Out-File -Encoding ASCII $cmdPath

$yedIcon = "$toolsDir\icons\yIcon.ico"
$pp = Get-PackageParameters
if ( !$pp.NoShortcut ) {
    Write-Host "Creating desktop shortcut"
    Install-ChocolateyShortcut -shortcutFilePath "$env:USERPROFILE\Desktop\yed.lnk" -targetPath $cmdPath -IconLocation $yedIcon
}

if ( !$pp.NoStartMenu ) {
    Write-Host "Creating Start menu shortcut"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\yed.lnk" -targetPath $cmdPath -IconLocation $yedIcon
}

if ( !$pp.NoAssociate ) {
    ".graphml", ".graphmlz", ".ygf", ".gml", ".xgml", ".tgf", ".ged" | % {
        "Associating $_"
        Install-ChocolateyFileAssociation -Extension $_ -Executable $cmdPath
    }
}

Register-Application $cmdPath yed
Write-Host "Application registered as yed"
