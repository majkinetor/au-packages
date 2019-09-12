$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
ls $toolsPath\helpers\*.ps1 | % { . $_ }


$Env:COMMANDER_PLUGINS_PATH = Join-Path (Get-ToolsLocation) TCPlugins
mkdir -ea 0 $Env:COMMANDER_PLUGINS_PATH

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName 
    FileFullPath   = gi $toolsPath\uninstaller64_1.0.1.rar
    FileFullPath64 = gi $toolsPath\uninstaller64_1.0.1.rar
    Destination    = "$Env:COMMANDER_PLUGINS_PATH\Uninstaller64"
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.rar -ea 0

Set-DCPlugin Uninstaller64
