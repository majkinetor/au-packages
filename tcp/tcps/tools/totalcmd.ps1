function Test-TC { $null -ne (Get-TCConfig -Path) }

function Close-TC() {
    $totalcmd = Get-Process totalcmd* -ea 0
    if (!$totalcmd) { return }
    $totalcmd | % { $_.CloseMainWindow() | Out-Null }
}

function Get-TCInstallPath {
    function check($path) { (gi $path\totalcmd.exe -ea 0).VersionInfo.InternalName -eq 'TOTALCMD' }
    
    $res = $Env:COMMANDER_PATH
    if ( check $res ) { return $res }

    $res = (gp 'HKCU:\Software\Ghisler\Total Commander' -ea 0).InstallDir
    if ( check $res ) { return $res }

    $res = (gp 'HKLM:\Software\Ghisler\Total Commander' -ea 0).InstallDir
    if ( check $res ) { return $res }
}

function Get-DCConfig ([switch] $Path) { 
    $cfg_path = "$Env:AppData\doublecmd\doublecmd.xml"
    if (!(Test-Path $cfg_path)) { return }

    if ($Path) { return $cfg_path }
    return ([xml](Get-Content $cfg_path))
}

function Get-TCConfig( [switch] $Path ) {
    function ini_path {
        $res = $Env:COMMANDER_INI
        if ( $res -and (Test-Path $res)) { return $res }

        $res = (gp 'HKCU:\Software\Ghisler\Total Commander' -ea 0).IniFileName
        if ( $res -and (Test-Path $res)) { return $res }

        $res = (gp 'HKLM:\Software\Ghisler\Total Commander' -ea 0).IniFileName
        if ( $res -and (Test-Path $res)) { return $res }

        $res = "$Env:AppData\Ghisler\wincmd.ini"
        if ( $res -and (Test-Path $res)) { return $res }

        $res = "$Env:WinDir\wincmd.ini"
        if ( $res -and (Test-Path $res)) { return $res }
    }

    $cfg_path = ini_path
    if (!(Test-Path $cfg_path)) { return }

    if ($Path) { return $cfg_path }
    return (Get-Content $cfg_path -Encoding UTF8 -Raw )
}

function Set-TCConfig( $ini ) {
    $ini_path = Get-TCConfig -Path
    Save-Content $ini_path $ini
}

function Set-TCPlugin {
    param(
        [string] $Name,
        [string] $PluginsPath = $Env:COMMANDER_PLUGINS_PATH,
        [switch] $x32,
        [switch] $Uninstall
    )

    Get-TCPluginInfo $Name $PluginsPath $x32

    $config = Get-TCConfig
    
    if (!$Uninstall) {
        if ($global:TCP_PluginType -in 'wfx','wcx') {
            $config = $config | Set-IniValue FileSystemPlugins $Name $global:TCP_PluginFile.FullName `
                              | Set-IniValue FileSystemPlugins64 $Name 1       
        } else {
            Write-Warning "This plugin type is not yet supported"
        }
    } else {
        $config = $config | Set-IniValue FileSystemPlugins $Name | Save-Content $iniPath
    }

    Close-TC
    Set-TCConfig $config

    # 'FileSystemPlugins'    Name=Path
    # 'PackerPlugins'        Name=Path
    # 'ListerPlugins'        No=Path
    # 'ContentPlugins'       No=Path
}

function Save-Content([string] $Path, [Parameter(ValueFromPipeline=$true)] [string] $Text) {
    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
    [System.IO.File]::WriteAllText($Path, $Text, $Utf8NoBomEncoding)
}
