<#
    Last Change: 12-Aug-2016.
    Author: M. Milic <miodrag.milic@gmail.com>

.SYNOPSIS
    Register application in the system

.DESCRIPTION

.NOTES
    See topic 'Application Registration' at https://msdn.microsoft.com/en-us/library/windows/desktop/ee872121(v=vs.85).aspx
#>

function Register-Application{
    [CmdletBinding()]
    param(
        # Full path of the executable to register
        [Parameter(Mandatory=$true)]
        [string]$ExePath,
        # Register application only for the current user. By default registration is for the machine
        [switch]$User
    )

    if (!(Test-Path $ExePath)) { throw "Path doesn't exist: $ExePath" }
    $exeName = Split-Path $ExePath -Leaf

    $appPathKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"
    if ($User) { $appPathKey = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName" }

    If (!(Test-Path $AppPathKey)) { New-Item "$AppPathKey" | Out-Null }
    Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value $exePath
}
