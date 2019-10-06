. $PSScriptRoot\doublecmd.ps1
. $PSScriptRoot\totalcmd.ps1
. $PSScriptRoot\ini.ps1

function Get-CallingPackageToolsDir
{
    $cStack = @(Get-PSCallStack)
    Split-Path $cStack[$cStack.Length-3].InvocationInfo.MyCommand.Source
}

function Install-TCPlugin($Name) {
    $toolsPath = Get-CallingPackageToolsDir

    if (!$Env:COMMANDER_PLUGINS_PATH) { $Env:COMMANDER_PLUGINS_PATH = Join-Path (Get-ToolsLocation) TCPlugins }
    mkdir -ea 0 $Env:COMMANDER_PLUGINS_PATH

    $packageArgs = @{
        PackageName    = $Env:ChocolateyPackageName 
        FileFullPath   = gi $toolsPath\*$Name* -Include '*.rar','*.zip'
        FileFullPath64 = gi $toolsPath\*$Name* -Include '*.rar','*.zip'
        Destination    = "$Env:COMMANDER_PLUGINS_PATH\$Name"
    }
    Get-ChocolateyUnzip @packageArgs
    Remove-Item $packageArgs.FileFullPath -ea 0

    $pp = Get-PackageParameters
    if (!$pp.NoDC) {
        Write-Host "Setting up Double Commander"
        Close-DC
        Set-DCPlugin $Name
    }
}

function Uninstall-TCPlugin($Name) {
    
}