function Add-AppRunPath([string]$ExePath, [switch]$User) {
    $exeName = Split-Path $ExePath -Leaf

    $appPathKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"
    if ($User) { $appPathKey = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"

    If (!(Test-Path $AppPathKey)) {New-Item "$AppPathKey" | Out-Null}
    Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value $exePath
}
