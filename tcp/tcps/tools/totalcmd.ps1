. $PSScriptRoot\ini.ps1

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

function Get-TCConfig( [switch] $Path ) {
    function ini_path {
        # $res = $Env:COMMANDER_INI
        # if ( $res -and (Test-Path $res)) { return $res }

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

function Set-TCPlugin {
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
    
    $configPath = Get-TCConfig -Path
    $sectionName = @{Wlx='ListerPlugins'; Wfx='FileSystemPlugins'; Wdx='ContentPlugins'; Wcx='PackerPlugins'}.$pType
    
    if ($Uninstall) {
        switch ($pType) {
            {$_ -in 'Wcx','Wlx','Wdx' } {       
                $iniSection = Get-IniSection $configPath $sectionName
                $iniSection | sls $PluginPath -SimpleMatch  | % {
                    $key = $_ -split "=",2 | select -first 1
                    Set-IniKey $configPath $sectionName $key | Out-Null
                    if ($_ -in 'Wlx','Wdx') { Set-IniKey $configPath $sectionName ${key}_detect | Out-Null }
                }
                if ($_ -in 'Wlx','Wdx') {
                    # Reorder other keys once a plugin is removed
                    $iniSection = Get-IniSection $configPath $sectionName | sort
                    $s = @(); $j=0
                    for ($i=0; $i -lt $iniSection.Count; $i++) {
                        $key, $val = $iniSection[$i] -split "=", 2
                        $key = $key.Trim()
                        if ($key -like '*_detect') {                            
                            $lastkey = $j++
                            $s += "$($lastkey)_detect=$val"
                        }  elseif ($key -match '\d+') {
                            $s += "$lastkey=$val"
                        }
                    }
                    $s = $s -join "`n"
                    Set-IniSection $configPath $sectionName $s | Out-Null
                }
            }
            'Wfx' {
                Set-IniKey $configPath $sectionName     $pName | Out-Null
                Set-IniKey $configPath ${sectionName}64 $pName | Out-Null
            }
        }
        return
    }

    switch ($pType) {
        'Wcx' {
            foreach ($ext in $archiveExts) { Set-IniKey $configPath $sectionName $ext $PluginPath | Out-Null }
        }
        {$_ -in 'Wdx','Wlx' } {
            $iniSection = Get-IniSection $configPath $sectionName
            $iniSection | sls $PluginPath -SimpleMatch  | % {
                $key = $_ -split "=",2 | select -first 1
                Set-IniKey $configPath $sectionName $key | Out-Null
                Set-IniKey $configPath $sectionName ${key}_detect | Out-Null
            }

            $iniSection = Get-IniSection $configPath $sectionName                 
            $cnt = $iniSection | % { $_ -split '=' | select -first 1 } | sort | select -last 1
            $cnt = if ($cnt) { 1+($cnt -replace '_.+') } else { 0 }
            $cnt = $cnt.ToString()
            Set-IniKey $configPath $sectionName $cnt $PluginPath | Out-Null
            if ($DetectString) { Set-IniKey $configPath $sectionName ${cnt}_detect $DetectString | Out-Null }
        }
        'Wfx' {
            Set-IniKey $configPath $sectionName $pName $PluginPath | Out-Null
        }        
    }
}

#Close-TC
#Set-TCPlugin "C:\tools\TCPlugins\DiskDirExtended\DiskDirExtended.wcx64" -ArchiveExt 'list ls'
#Set-TCPlugin "C:\tools\TCPlugins\EnvVars\envvars.wfx64"
#Set-TCPlugin "C:\tools\TCPlugins\ShellDetails\ShellDetails.wdx64"
#Set-TCPlugin "C:\tools\TCPlugins\LinkInfo\LinkInfo.wlx64" -DetectString 'EXT="LNK"'
