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
    
    $configPath = Get-TCConfig -Path
    $sectionName = @{Wlx='ListerPlugins'; Wfx='FileSystemPlugins'; Wdx='ContentPlugins'; Wcx='PackerPlugins'}.$pType
    
    if ($Uninstall) {
        switch ($pType) {
            {$_ -in 'Wcx','Wlx' } {       
                $iniSection = Get-IniSection $configPath $sectionName
                $iniSection | sls $PluginPath -SimpleMatch  | % {
                    $key = $_ -split "=",2 | select -first 1
                    Set-IniKey $configPath $sectionName $key
                    if ($_ -eq 'Wlx') { Set-IniKey $configPath $sectionName ${key}_detect }
                }
                if ($_ -eq 'Wlx') {
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
                    $config = Set-IniSection $configPath $sectionName $s
                }
            }
            default {
                Set-IniKey $configPath $sectionName     $pName
                Set-IniKey $configPath ${sectionName}64 $pName
            }
        }
    }

    switch ($pType) {
        'Wcx' {
            foreach ($ext in $archiveExts) { Set-IniKey $configPath $sectionName $ext $PluginPath }
        }
        'Wlx' {
            $iniSection = Get-IniSection $configPath $sectionName
            $iniSection | sls $PluginPath -SimpleMatch  | % {
                $key = $_ -split "=",2 | select -first 1
                Set-IniKey $configPath $sectionName $key
                Set-IniKey $configPath $sectionName ${key}_detect
            }

            $iniSection = Get-IniSection $configPath $sectionName                 
            $cnt = $iniSection | % { $_ -split '=' | select -first 1 } | sort | select -last 1
            $cnt = if ($cnt) { 1+($cnt -replace '_.+') } else { 0 }
            $cnt = $cnt.ToString()
            Set-IniKey $configPath $sectionName $cnt $PluginPath
            if ($DetectString) { Set-IniKey $configPath $sectionName ${cnt}_detect $DetectString }
        }
        default {
            Set-IniKey $configPath $sectionName $pName $PluginPath 
        }        
    }
}

#Set-DCPlugin "C:\tools\TCPlugins\DiskDirExtended\DiskDirExtended.wcx64" -ArchiveExt 'list ls'
#Set-DCPlugin "C:\tools\TCPlugins\EnvVars\envvars.wfx64"
#Set-DCPlugin "C:\tools\TCPlugins\ShellDetails\ShellDetails.wdx64"
# Close-TC
# Set-DCPlugin "C:\tools\TCPlugins\LinkInfo\LinkInfo.wlx64" -DetectString 'EXT="LNK"' -Uninstall
