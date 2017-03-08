$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

Update-SessionEnvironment #java might be installed

$javaw_path = gcm javaw | % { $_.Source }
if (!$javaw_path) { throw "javaw is not on the PATH" }

# Create desktop shortcut
$params = @{
    ShortcutFilePath = "$Env:USERPROFILE\Desktop\plantuml.lnk"
    TargetPath       = $javaw_path
    Arguments        = "-jar ""$toolsPath\plantuml.jar"""
    IconLocation     = "$toolsPath\plantuml.ico"
}
Install-ChocolateyShortcut @params

# Create additional shortcut in tools directory for Register-Application
$params.ShortcutFilePath = "$toolsPath\plantuml.lnk"
Install-ChocolateyShortcut @params

Register-Application "$toolsPath\plantuml.lnk" plantuml
Write-Host "$packageName registered as $packageName"
