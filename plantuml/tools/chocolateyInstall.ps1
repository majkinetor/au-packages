$ErrorActionPreference = 'Stop'
Update-SessionEnvironment   #java might have been installed

$packageName = 'plantuml'
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition
$java_args   = '-Dfile.encoding=UTF-8 -jar "{0}"' -f "$toolsPath\plantuml.jar"

$javaw_path = (gcm javaw.exe -ea 0).Path
$java_path  = (gcm java.exe -ea 0).Path
if (!$javaw_path) { throw "javaw.exe is not on the PATH" }
Write-Host "Using javaw: $javaw_path"
Write-Host "Using java: $java_path"

$pp = Get-PackageParameters

# Create shortcut in tools directory for Register-Application
$params = @{
    ShortcutFilePath = "$toolsPath\plantuml.lnk"
    TargetPath       = $javaw_path
    Arguments        = $java_args
    IconLocation     = "$toolsPath\plantuml.ico"
}
Install-ChocolateyShortcut @params

Register-Application "$toolsPath\plantuml.lnk" plantuml
Write-Host "$packageName registered as $packageName"

# This binary is for interactive work (returns asap)
$binparams = @{
    name     = "plantuml"
    path     = $javaw_path
    useStart = $true
    command  = """$java_args"""
}
Install-BinFile @binparams

# This binary is for scripting, it waits for java to return
$binparams = @{
    name =  "plantumlc"
    path = $java_path
    useStart = $false
    command = """$java_args"""
}
Install-BinFile @binparams

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