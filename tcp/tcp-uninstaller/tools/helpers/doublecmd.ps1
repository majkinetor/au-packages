$is64 = (Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true'

function Get-DCConfig ([switch] $Path) { 
    $cfg_path = "$Env:AppData\doublecmd\doublecmd.xml"
    if (!(Test-Path $cfg_path)) { throw "Can't find DC config at: $cfg_path"}

    if ($Path) { return $cfg_path }
    return ([xml](Get-Content $cfg_path))
}

function Set-DCConfig( $xml ) {
    $cfg_path = Get-DCConfig -Path
    $xml.Save($cfg_path)
}


# - Must kill DC before changing is config as it will overwrite changes on shutting down
# - Shold use COMMANDER_PLUGINS_PATH instead of full path
function Set-DCPlugin {
    param(
        [string] $Name
    )

    $plugin_types = 'wcx', 'wdx', 'wfx', 'wlx'

    $config = Get-DCConfig

    $config.doublecmd.Plugins.PluginPathToBeRelativeTo = "%COMMANDER_PLUGINS_PATH%"
    
    $wfxPlugin = $config.doublecmd.Plugins.WfxPlugins.WfxPlugin | ? { $_.Name -eq $Name }
    if (!$wfxPlugin) { 
        $wfxPlugin = $config.CreateElement("WfxPlugin")
        $wfxPlugin.Attributes.Append( $config.CreateAttribute('Enabled') ) | Out-Null
       
        "Name", "Path" | % { $wfxPlugin.AppendChild( $config.CreateElement($_)) | Out-Null } 
        $config.doublecmd.Plugins.WfxPlugins.AppendChild( $wfxPlugin ) | Out-Null
    }

    $paths = ls -recurse $Env:COMMANDER_PLUGINS_PATH\*\$Name.w*   
    if (!$paths) { throw "Can't find plugin by the name $Name" }    
    $paths[0].ToString() -match '(?<=\.)w..(?=(?:..)?$)' | Out-Null
    $pluginType = $Matches[0]
    if ($pluginType -notin $plugin_types ) { throw "Can't find valid plugin extension" }

    $wfxPlugin.Enabled = 'True'
    $wfxPlugin.Name    = $Name    
    $wfxPlugin.Path    = if ($is64) { $paths -like "*.${pluginType}64" } else {  $paths -like "*.${pluginType}"}
    
    Set-DCConfig $config
    Write-Host "Double Commander plugin added: $Name"
}