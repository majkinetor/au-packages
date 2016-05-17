<#
    Last Change: 17-May-2016.
    Author: M. Milic <miodrag.milic@gmail.com>

.SYNOPSIS
    Register application in the system

.DESCRIPTION

.NOTES
    See topic 'Application Registration' at https://msdn.microsoft.com/en-us/library/windows/desktop/ee872121(v=vs.85).aspx
.EXAMPLE
.OUTPUTS
#>

function Register-Application{
    [CmdletBinding()]
    param(
        [string]$ExePath,
        [switch]$User
    )

    $exeName = Split-Path $ExePath -Leaf

    $appPathKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"
    if ($User) { $appPathKey = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"

    If (!(Test-Path $AppPathKey)) {New-Item "$AppPathKey" | Out-Null}
    Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value $exePath
}
