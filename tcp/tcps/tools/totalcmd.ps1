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
    if (!$cfg_path) { return }

    if ($Path) { return $cfg_path }
    return (Get-Content $cfg_path -Encoding UTF8 -Raw )
}

function Set-TCConfig( $ini ) {
    function Save-Content([string] $Path, [Parameter(ValueFromPipeline=$true)] [string] $Text) {
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
        [System.IO.File]::WriteAllText($Path, $Text, $Utf8NoBomEncoding)
    }
    $ini_path = Get-TCConfig -Path    
    Save-Content $ini_path $ini
}

function Set-TCPlugin ( [switch] $Uninstall ) {
    $pluginName = $global:TCP_PluginFile.BaseName.ToString()
    $sectionName = @{Wlx='ListerPlugins'; Wfx='FileSystemPlugins'; Wdx='ContentPlugins'; Wcx='PackerPlugins'}[$global:TCP_PluginType]
    $config = Get-TCConfig
    
    if (!$Uninstall) {
        if ($sectionName -in 'FileSystemPlugins','PackerPlugins') {
            $config = $config | Set-IniValue $sectionName $pluginName $global:TCP_PluginFile.FullName
            if (!$x32) { $config = $config | Set-IniValue "${sectionName}64" $pluginName 1 }  
        } else {
            $iniSection = (Get-IniSection $config $sectionName) -split "`n"
            if ($iniSection | sls $global:TCP_PluginFile.Name) { return }

            $cnt = $iniSection  | select -skip 1 | % { $_ -split '=' | select -first 1 } | sort | select -last 1
            $cnt = if ($cnt) { 1+($cnt -replace '_.+') } else { 0 }
            $config = $config | Set-IniValue $sectionName $cnt $global:TCP_PluginFile.FullName
        }
    } else {
        if ($sectionName -in 'FileSystemPlugins','PackerPlugins') {
            $config = $config | Set-IniValue $sectionName $pluginName
            if (!$x32) { $config = $config | Set-IniValue "${sectionName}64" $pluginName }   
        } else {
            $iniSection = (Get-IniSection $config $sectionName) -split "`n"
            $line = $iniSection | sls $global:TCP_PluginFile.Name
            $cnt = $line -split "=" | select -first 1
            $cnt = $cnt -replace '_.+'
            $config = $config | Set-IniValue $sectionName $cnt `
                              | Set-IniValue $sectionName "${cnt}_detect"
        }
    }
    Set-TCConfig $config
}
