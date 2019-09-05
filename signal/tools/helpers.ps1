
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

function Set-SignalOptions {
    $batPath = "$toolsPath\signal.bat"

    $bat = Get-Content $batPath -Encoding ascii
    if (!$pp.NoTray) {
        Write-Host "Setting tray icon option"
        $bat = $bat -replace "^(::)(.+)$", '$2'
    }

    if (!$pp.NoProxy) {
        $proxy = Get-EffectiveProxy
        Write-Host "Setting proxy to $proxy"
        $bat = $bat -replace "HTTP_PROXY=","`$0$proxy"
    }

    $bat | Set-Content -Encoding ascii $batPath
}
