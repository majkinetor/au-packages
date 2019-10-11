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
    if (!$cfg_path) {
        $exePath = "$Env:ProgramFiles\Double Commander\doublecmd.exe"
        if (!(Test-Path $exePath)) {
            $exePath = "$Env:COMMANDER_PATH\doublecmd.exe"
            if (!(Test-Path $exePath)) { return }
        }

        Write-Host "Double Commander config file is not found while its executable exists"
        Write-Host "It will now be run and closed for the first time to generate config file"
        Start-Process $exePath -WindowStyle Hidden
        Start-Sleep 1
        for ($i=0; $i -lt 5; $i++) {
            $doublecmd = Get-Process doublecmd -ea 0
            if (!$doublecmd) { Start-Sleep 1; continue }
            $doublecmd.CloseMainWindow() | Out-Null
            Start-Sleep 1
            break
        }
        $cfg_path = xml_path
        if (!$cfg_path) { return }
    }

    if ($Path) { return $cfg_path }
    return ([xml](Get-Content $cfg_path))
}

function Set-DCConfig( $xml ) {
    $cfg_path = Get-DCConfig -Path
    $xml.Save($cfg_path)
}

function Set-DCOptions([Parameter(ValueFromPipeline=$true)][HashTable]$Options, $UserConfig) {
    $config = if ($UserConfig) { $UserConfig } else { Close-DC; Get-DCConfig }
    if (!$config) { Write-Warning "Can't find Double Commander config, doing nothing"; return } # This prevent Gallery verifyer to fail as it runs as a user SYSTEM which has different profile path
    
    foreach ($section in $Options.Keys) {        
        foreach ($key in $Options.$section.Keys) {
            $prefix = ''; $xmlkey = $key
            if ($key.IndexOf('.') -ne -1) { 
                $prefix = $key -replace '\.[^.]+$'
                $xmlkey = $key.Replace("$prefix.",'')
                $prefix = ".$prefix"
            }

            $xml_path = "`$config.doublecmd.${section}${prefix}['$xmlkey']"
            $node = try { iex $xml_path } catch { Write-Warning "Can't set value for '$section.$key': $_"; continue }
            $val = $Options.$section.$key

            if ( $val -is [HashTable]) {
                foreach( $a in $val.Keys) {
                    $node.Attributes.Append( $config.CreateAttribute( $a ) ) | Out-Null
                    $node.$a = $val.$a.ToString()
                }
            } else { 
                try { $node.InnerText = $val.ToString() } catch { Write-Warning "Can't set value for '$section.$key': $_"; }
            }
        }
    }
    if (!$UserConfig) { Set-DCConfig $config }
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

        # Force specific plugin type
        [string] $ForceType,
        
        # Set to remove plugin from settings file
        # Packer plugins: all instances will be removed
        [switch] $Uninstall
    )  
    function Capitalize($s) { $s.Substring(0,1).ToUpper() + $s.Substring(1) }
    
    $pFile = Get-Item $PluginPath
    $pName = Capitalize $pFile.BaseName.ToString()
    $pType = if ($ForceType) { $ForceType } else { Capitalize $pFile.Extension.Substring(1).Replace('64','') }
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
    $plugins | % { $config.doublecmd.Plugins["${pType}Plugins"].AppendChild( $_ ) | Out-Null }

    Set-DCConfig $config
}

# Close-DC
#Set-DCPlugin "C:\tools\TCPlugins\DiskDirExtended\DiskDirExtended.wcx64" -ArchiveExt 'list ls'
#Set-DCPlugin "C:\tools\TCPlugins\EnvVars\envvars.wfx64"
#Set-DCPlugin "C:\tools\TCPlugins\FileInfo\fileinfo.wlx64" -DetectString 'EXT="WAV" | EXT="AVI"'
# Set-DCPlugin "C:\tools\TCPlugins\Linkinfo\Linkinfo.wlx64" -DetectString 'EXT="LNK"'
#Set-DCPlugin "C:\tools\TCPlugins\ShellDetails\ShellDetails.wdx64"
# Set-DCPlugin "C:\tools\TCPlugins\Uninstaller64\Uninstaller64.wfx"