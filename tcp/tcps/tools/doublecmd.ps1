function Test-DC() { $null -ne (Get-DCConfig -Path) }

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

function Set-DCPlugin {
    param(
        # Full path to the one of the supported TC plugins to add to settings file
        [string] $PluginPath,
        
        # Lister and Content plugins: A string which determines whether plugin can handle the file or not
        # For semantics see http://java.totalcmd.net/V1.7/javadoc/plugins/wlx/WLXPluginInterface.html#listGetDetectString(int)
        [string] $DetectString,
        
        # Packer plugins: Space separated list of extensions to associate with this plugin
        [string] $ArchiveExt,
        
        # Set to remove plugin from settings file
        # Packer plugins: all instances will be removed
        [switch] $Uninstall
    )  
    function Capitalize($s) { $s.Substring(0,1).ToUpper() + $s.Substring(1) }
    
    $pFile = Get-Item $PluginPath
    $pName = Capitalize $pFile.BaseName.ToString()
    $pType = Capitalize $pFile.Extension.Substring(1).Replace('64','')
    $archiveExts = $archiveExt -split ' '
    
    $config = Get-DCConfig

    $all_plugins = $config.doublecmd.Plugins."${pType}Plugins"."${pType}Plugin"   
    $plugins = $all_plugins | ? { if ($pType -eq 'Wcx') { $_.Path -eq $PluginPath } else { $_.Name -eq $pName } }
    $plugins | % { $config.doublecmd.Plugins."${pType}Plugins".RemoveChild( $_ ) | Out-Null }
    if ($Uninstall)  { return Set-DCConfig $config }
    
    # Create XML node for plugin
    $elements = @{
        Wfx = 'Name', 'Path'
        Wcx = 'ArchiveExt', 'Path', 'Flags'
        Wlx = 'Name', 'Path', 'DetectString'
        Wdx = 'Name', 'Path', 'DetectString'
    }
    $plugin = $config.CreateElement("${pType}Plugin") 
    $elements.$pType | % { $plugin.AppendChild($config.CreateElement($_)) } | Out-Null
    $plugin.Attributes.Append( $config.CreateAttribute('Enabled') ) | Out-Null

    # Set node values where they exist
    $plugin.Enabled = 'True'
    $plugin.Path = $PluginPath
    try { $plugin.Name         = $pName }        catch {}
    try { $plugin.DetectString = $DetectString } catch {}
    try { $plugin.Flags        = '31' }          catch {}

    $plugins = if ($pType -eq 'Wcx') { 
        foreach ($ext in $archiveExts) { $p = $plugin.Clone(); $p.ArchiveExt = $ext; $p }
    } else { $plugin }
    $plugins | % { $config.doublecmd.Plugins."${pType}Plugins".AppendChild( $_ ) | Out-Null }

    Set-DCConfig $config
}

#Close-DC
#Set-DCPlugin "C:\tools\TCPlugins\DiskDirExtended\DiskDirExtended.wcx64" -ArchiveExt 'list ls'
#Set-DCPlugin "C:\tools\TCPlugins\EnvVars\envvars.wfx64"
#Set-DCPlugin "C:\tools\TCPlugins\ShellDetails\ShellDetails.wdx64"
#Set-DCPlugin "C:\tools\TCPlugins\FileInfo\fileinfo.wlx64" -DetectString 'EXT="WAV" | EXT="AVI"'