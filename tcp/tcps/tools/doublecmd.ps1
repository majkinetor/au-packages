function Test-DC() { $null -ne (Get-DCConfig) }

function Close-DC() {
    $doublecmd = Get-Process doublecmd -ea 0
    if (!$doublecmd) { return }
    $doublecmd | % { $_.CloseMainWindow() | Out-Null }
}

function Get-DCConfig ([switch] $Path) { 
    function xml_path {
        $res = "$Env:AppData\doublecmd\doublecmd.xml"
        if (Test-Path $res) {return $res}

        $res = "$Env:ProgramFiles\Double Commander\doublecmd.xml"
        if (Test-Path $res) {return $res}
    }
    $cfg_path = xml_path
    if (!$cfg_path) { return }

    if ($Path) { return $cfg_path }
    return ([xml](Get-Content $cfg_path))
}

function Set-DCConfig( $xml ) {
    $cfg_path = Get-DCConfig -Path
    $xml.Save($cfg_path)
}

# Must close DC before changing its config if 'save on exit' option is on as it will overwrite changes on shutting down
function Set-DCPlugin ([switch] $Uninstall){
    $pluginName = $global:TCP_PluginFile.BaseName.ToString()
    $config = Get-DCConfig

    $plugin = $config.doublecmd.Plugins[$global:TCP_PluginType+'Plugins'].$($global:TCP_PluginType+'Plugin') | ? { $_.Name -eq $pluginName }
    if (!$plugin) {
        if ($Uninstall) { Write-Warning 'Plugin is already removd from Double Commander via other means'; return }
        
        $plugin = $config.CreateElement($global:TCP_PluginType+"Plugin")
        #$plugin.Attributes.Append( $config.CreateAttribute('Enabled') ) | Out-Null
        "Name", "Path" | % { $plugin.AppendChild($config.CreateElement($_)) } | Out-Null
        $config.doublecmd.Plugins[$global:TCP_PluginType+'Plugins'].AppendChild( $plugin ) | Out-Null
    }
    if (!$Uninstall) {
        #$plugin.Enabled = 'True'
        $plugin.Name    = $pluginName
        $plugin.Path    = $global:TCP_PluginFile.FullName
    } else {
        $config.doublecmd.Plugins[$global:TCP_PluginType+'Plugins'].RemoveChild( $plugin ) | Out-Null
    }
    Close-DC
    Set-DCConfig $config
}
