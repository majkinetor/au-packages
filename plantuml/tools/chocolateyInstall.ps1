$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$url         = 'https://sourceforge.net/projects/plantuml/files/plantuml.8057.jar/download'
$checksum    = '5519dea83f6a3890cee67655a51932aa0fe6c50000890e5723255cd05f8e0af7'
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$params = @{
    PackageName    = $packageName
    FileFullPath   = "$toolsPath\plantuml.jar"
    Url            = $url
    Url64Bit       = $url
    checksum       = $checksum
    checksum64     = $checksum
    checksumType   = 'sha256'
    checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @params

# Create desktop shortcut
$params = @{
    ShortcutFilePath = "$Env:USERPROFILE\Desktop\plantuml.lnk"
    TargetPath       = gcm javaw | % { $_.Source }
    Arguments        = "-jar ""$toolsPath\plantuml.jar"""
    IconLocation     = "$toolsPath\plantuml.ico"
}
Install-ChocolateyShortcut @params

# Create additional shortcut in tools directory for Register-Application
$params.ShortcutFilePath = "$toolsPath\plantuml.lnk"
Install-ChocolateyShortcut @params

Register-Application "$toolsPath\plantuml.lnk" plantuml
Write-Host "$packageName registered as $packageName"
