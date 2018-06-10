<#
Author: Miodrag Milic <miodrag.milic@gmail.com>
This script contains various Total Commander functions
#>

function Test-Commander {
    if (!($Env:COMMANDER_PATH -and (Test-Path $Env:COMMANDER_PATH))) { throw 'This package requires COMMANDER_PATH environment variable set' }
    if (ps totalcmd* -ea 0) {
        Write-Warning "Total Commander is running; restart it for any changes to take effect"
    }
}

function Install-TCPlugin([string] $Path, [string] $Name ) {
    $plugin_name = Split-Path $Path -Leaf
    $plugins_path = "$Env:COMMANDER_PATH\plugins"
    mkdir $plugins_path -ea 0 | Out-Null
    
    $tmpDestination = "$Env:TEMP\_tcp\$plugin_name"
    rm $tmpDestination -Recurse -ea 0
    Get-ChocolateyUnzip -FileFullPath $Path -Destination $tmpDestination
   
    $plugin_types = 'wfx', 'wlx', 'wcx', 'wdx'
    $subdir = $plugin_types | ? { ([array](ls $tmpDestination\* -Include *$_*)).Count -gt 0 } | select -First 1
    if (!$subdir) { throw "Plugin type must be one of the: $plugin_types" }

    $plugin_path = "$plugins_path\$subdir\$Name"

    rm $plugin_path -Recurse -Force -ea 0
    mkdir $plugin_path -ea 0 | Out-Null
    mv $tmpDestination\* $plugin_path -Force
    
    Write-Host "TotalCmd plugin installed at: $plugin_path" 

    # $iniPath = gc "$Env:APPDATA\GHISLER\wincmd.ini"

    # 'FileSystemPlugins'     Name=Path
    # 'ListerPlugins' wlx ordered
    # 'PackerPlugins' Name=Path
    # 'ContentPlugins' wdx ordered

    # $sectionNo = ($ini -split '\n' | sls '^\s*\[.+?\]').Count
}
function Uninstall-TCPlugin([string] $Name) {
    Write-Host "Removing TotalCmd plugin files: $Name"
    rm $Env:COMMANDER_PATH\plugins\*\$Name -Recurse -Force
}

Test-Commander