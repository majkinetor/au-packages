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

function Set-DCPlugin([switch] $Uninstall, [string] $DetectString, [string] $ArchiveExt) {
    $pluginName = $global:TCP_PluginFile.BaseName.ToString()
    $config = Get-DCConfig

    $all_plugins = $config.doublecmd.Plugins[$global:TCP_PluginType+'Plugins'].$($global:TCP_PluginType+'Plugin')
    $plugin = $all_plugins | ? { $_.Name -eq $pluginName -or $_.ArchiveExt -eq $ArchiveExt }
    if (!$plugin) { $plugin = $config.CreateElement($global:TCP_PluginType+"Plugin") }

    $elements = @{
        Wfx = 'Name', 'Path'
        Wcx = 'ArchiveExt', 'Path', 'Flags'
        Wlx = 'Name', 'Path', 'DetectString'
        Wdx = 'Name', 'Path', 'DetectString'
    }
    $elements[$global:TCP_PluginType] | % { if ($plugin.$_ -eq $null) { $plugin.AppendChild($config.CreateElement($_)) }} | Out-Null
    if ($plugin.Enabled -eq $null) { $plugin.Attributes.Append( $config.CreateAttribute('Enabled') ) | Out-Null }

    if ($Uninstall) {
        $config.doublecmd.Plugins[$global:TCP_PluginType+'Plugins'].RemoveChild( $plugin ) | Out-Null
    } else {
        $plugin.Enabled = 'True'
        $plugin.Path    = $global:TCP_PluginFile.FullName
        try { $plugin.Name = $pluginName }              catch {}
        try { $plugin.DetectString = $DetectString }    catch {}
        try { $plugin.ArchiveExt= 'ls' }                catch {}
        try { $plugin.Flags= '31' }                     catch {}

        $config.doublecmd.Plugins[$global:TCP_PluginType+'Plugins'].AppendChild( $plugin ) | Out-Null
    }

    Set-DCConfig $config
}

# Must close DC before changing its config if 'save on exit' option is on as it will overwrite changes on shutting down
