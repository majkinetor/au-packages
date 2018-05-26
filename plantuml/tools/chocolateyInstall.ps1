$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helper.ps1

Update-SessionEnvironment   # Java might have been installed as dependency

$java_path, $javaw_path = Get-JavaPaths
$java_args = '-Dfile.encoding=UTF-8 -jar "{0}"' -f "$toolsPath\plantuml.jar"
Write-Host "Java path: $(Split-Path $javaw_path)"
Write-Host "Java args: $java_args"

$pp = Get-PackageParameters

Install-PumlToolsShortcut
Install-PumlBinaryW
Install-PumlBinary
if (!$pp.NoShortcuts) { Install-PumlDesktopShortcuts }