$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

Update-SessionEnvironment #java might be installed

$javaw_path = gcm javaw.exe -ea 0 | % { $_.Path }
if (!$javaw_path) { throw "javaw.exe is not on the PATH" }
Write-Host "Using javaw: $javaw_path"

$pp = Get-PackageParameters

# # Create shortcut in tools directory for Register-Application
$params = @{
    ShortcutFilePath = "$toolsPath\plantuml.lnk"
    TargetPath       = $javaw_path
    Arguments        = "-jar ""$toolsPath\plantuml.jar"""
    IconLocation     = "$toolsPath\plantuml.ico"
}
Install-ChocolateyShortcut @params

Register-Application "$toolsPath\plantuml.lnk" plantuml
Write-Host "$packageName registered as $packageName"

if (!$pp.NoShortcuts) { 
    Write-Host "Creating desktop shortcuts"
    $params.ShortcutFilePath = "$Env:USERPROFILE\Desktop\Plantuml.lnk"
    Install-ChocolateyShortcut @params 

    $params = @{
        ShortcutFilePath = "$Env:USERPROFILE\Desktop\Plantuml Reference.lnk"
        TargetPath       = "$toolsPath\PlantUML_Language_Reference_Guide.pdf"
    }
    Install-ChocolateyShortcut @params
}

$binparams = @{
    name =  "plantuml"
    path = $params.TargetPath
    useStart = $true
    command = """$($params.Arguments)"""
}
Generate-BinFile @binparams