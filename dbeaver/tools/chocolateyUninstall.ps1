function UnInstall-DBeaver {
    $path = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DBeaver').UninstallString

    if($path -ne $null) {
        Uninstall-ChocolateyPackage 'dbeaver' 'exe' '/D /S' $path -validExitCodes @(0)
    }
}

UnInstall-DBeaver
