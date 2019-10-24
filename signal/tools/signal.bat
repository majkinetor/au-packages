set HTTP_PROXY=
set HTTPS_PROXY=%HTTP_PROXY%

::set SIGNAL_OPTIONS=--use-tray-icon --start-in-tray
start "" "%LOCALAPPDATA%\Programs\signal-desktop\Signal.exe" %SIGNAL_OPTIONS%
