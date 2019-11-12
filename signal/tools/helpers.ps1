function Install-DesktopShortcut {
    if ( $pp.NoShortcut ) { return } 

    Write-Host "Installing desktop shortcut"
    $params = @{
        ShortcutFilePath  = Join-Path ([Environment]::GetFolderPath("Desktop")) signal.lnk
        TargetPath        = "$toolsPath\signal.bat"
        IconLocation      = "$Env:LOCALAPPDATA\Programs\signal-desktop\Signal.exe"
        WindowStyle       = 7 # Minimized
    }
    Install-ChocolateyShortcut @params
}

function Set-AutoUpdate([switch]$Enable, [switch]$Disable) {
   $hostsPath = "$Env:WinDir\System32\drivers\etc\hosts"
   $content = Get-Content $hostsPath -Encoding ascii 

   if ($Disable) {
        if ($content | Select-String "127.0.0.1\s+updates.signal.org")  { return }
        $content,"127.0.0.1 updates.signal.org" | Out-File -Encoding ascii $hostsPath
    }

    if ($Enable) {
        if (!( $content | Select-String "127.0.0.1\s+updates.signal.org")) { return }
        $content | ? { $_ -notmatch "127.0.0.1\s+updates.signal.org" } | Out-File -Encoding ascii $hostsPath 
    }  
}

function Set-SignalOptions {
    $batPath = "$toolsPath\signal.bat"

    $bat = Get-Content $batPath -Encoding ascii
    if (!$pp.NoTray) {
        Write-Host "Setting tray icon option"
        $bat = $bat -replace "^(::)(.+)$", '$2'
    }

    if (!$pp.NoProxy) {
        $proxy = Get-EffectiveProxy
        if (!$proxy) { return }
        
        Write-Host "Setting proxy to $proxy"
        $bat = $bat -replace "HTTP_PROXY=","`$0$proxy"
    }

    $bat | Set-Content -Encoding ascii $batPath
}
