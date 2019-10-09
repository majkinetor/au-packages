. $PSScriptRoot\doublecmd.ps1
. $PSScriptRoot\totalcmd.ps1

if (!$Env:COMMANDER_PLUGINS_PATH) { $Env:COMMANDER_PLUGINS_PATH = Join-Path (Get-ToolsLocation) TCPlugins }
mkdir -ea 0 $Env:COMMANDER_PLUGINS_PATH

$TCP_Types = 'Wcx', 'Wdx', 'Wfx', 'Wlx'

function Get-TCPluginPath {
    param(
        [string] $Name,
        [string] $PluginsPath = $Env:COMMANDER_PLUGINS_PATH
    )
    $is32 = if ((Get-ProcessorBits 32) -or $env:chocolateyForceX86 -eq 'true') { $true } else { $false }

    $pluginExtensions = $TCP_Types | % { if ($is32) {"*.$_"} else {"*.${_}64"} }
    $pluginFile = Get-ChildItem -Recurse -Path $PluginsPath -Include $pluginExtensions -Filter "$Name.*" 
    if (!$pluginFile) { throw "Can't find plugin installation for the '$Name'" }
    if ($pluginFile.Count -gt 1) { throw "Multiple plugins found by the name '$Name': $($pluginFile.Name)"  }
    return $pluginFile.FullName
}

function Install-TCPlugin($Name, $DetectString, $ArchiveExt) {
    $packageArgs = @{
        PackageName    = $Env:ChocolateyPackageName 
        FileFullPath   = gi $toolsPath\*$Name* -Include '*.rar','*.zip'
        FileFullPath64 = gi $toolsPath\*$Name* -Include '*.rar','*.zip'
        Destination    = "$Env:COMMANDER_PLUGINS_PATH\$Name"
    }
    Get-ChocolateyUnzip @packageArgs
    Remove-Item $packageArgs.FileFullPath -ea 0

    $pluginPath = Get-TCPluginPath $Name
    if (Test-DC) {
        Write-Host "Adding plugin settings for Double Commander"
        Close-DC
        Set-DCPlugin $pluginPath -DetectString $DetectString -ArchiveExt $ArchiveExt
    }
    if (Test-TC) {
        Write-Host "Adding plugin settings for Total Commander"
        CLose-TC
        Set-TCPlugin $pluginPath -DetectString $DetectString -ArchiveExt $ArchiveExt
    }
}

function Uninstall-TCPlugin($Name) {
    $pluginPath = Get-TCPluginPath $Name
    
    if (Test-DC) {
        Write-Host "Removing plugin settings for Double Commander"
        Close-DC
        Set-DCPlugin $pluginPath -Uninstall
    }
    if (Test-TC) {
        Write-Host "Removing plugin settings for Total Commander"
        Close-TC
        Set-TCPlugin $pluginPath -Uninstall
    }

    Write-Host "Removing plugin files"
    Remove-Item $Env:COMMANDER_PLUGINS_PATH\$Name -Recurse
}

# $Name = 'DiskDirExtended'

# import-module C:\ProgramData\chocolatey\helpers\chocolateyInstaller.psm1
# $toolsPath = Resolve-Path $PSScriptRoot\..\..\tcp-$Name\tools
# $Env:COMMANDER_INI = ''
# $Env:COMMANDER_PLUGINS_PATH = Resolve-Path "$Env:ChocolateyToolsLocation\TCPlugins"
# Install-TCPlugin $Name -ArchiveExt 'list'
