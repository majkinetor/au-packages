
function Close-DC() {
    $doublecmd = Get-Process doublecmd -ea 0
    if (!$doublecmd) { return }
    $doublecmd | % { $_.CloseMainWindow() }
}

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

# Must close DC before changing its config if 'save on exit' option is on as it will overwrite changes on shutting down
function Set-DCPlugin {
    param(
        [string] $Name,
        [string] $PluginsPath = $Env:COMMANDER_PLUGINS_PATH,
        [switch] $x32
    )

    $plugin_types = 'Wcx', 'Wdx', 'Wfx', 'Wlx'

    $pluginExtensions = $plugin_types | % { if ($x32) {"*.$_"} else {"*.${_}64"} }
    $pluginFile = Get-ChildItem -Recurse -Path $PluginsPath -Include $pluginExtensions -Filter "$Name.*" 
    if (!$pluginFile) { throw "Can't find plugin by the name '$Name'" }
    if ($pluginFile.Count -gt 1) { throw "Multiple plugins found by the name '$Name': $($pluginFile.Name)"  } 
    $pluginType = $pluginFile.Extension.Substring(1) -replace '64'
    $pluginType = $pluginType.Substring(0,1).ToUpper() + $pluginType.Substring(1)

    $config = Get-DCConfig
    $plugin = $config.doublecmd.Plugins[$pluginType+'Plugins'].$($pluginType+'Plugin') | ? { $_.Name -eq $Name }
    if (!$plugin) { 
        $plugin = $config.CreateElement($pluginType+"Plugin")
        $plugin.Attributes.Append( $config.CreateAttribute('Enabled') ) | Out-Null
        "Name", "Path" | % { $plugin.AppendChild($config.CreateElement($_)) } | Out-Null
        #TODO: WlxPlugins didn't exist
        $config.doublecmd.Plugins[$pluginType+'Plugins'].AppendChild( $plugin ) | Out-Null
    }

    $plugin.Enabled = 'True'
    $plugin.Name    = $Name    
    $plugin.Path    = $pluginFile.FullName
    
    Set-DCConfig $config
}

$Env:COMMANDER_PLUGINS_PATH = "C:\tools\TCPlugins"
Set-DCPlugin 'fileinfo'