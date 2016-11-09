<#
    Last Change: 08-Nov-2016.
    Author: M. Milic <miodrag.milic@gmail.com>

.SYNOPSIS
    Register application in the system

.EXAMPLE
    Register-Application 'c:\windows\notepad.exe'

    Register application using name derived from its file name. Test via Win + R dialog.

.EXAMPLE
    Register-Application 'c:\windows\notepad.exe' -Name ntp

    Register application using explicit name.

.NOTES
    See topic 'Application Registration' at https://msdn.microsoft.com/en-us/library/windows/desktop/ee872121(v=vs.85).aspx
#>

function Register-Application{
    [CmdletBinding()]
    param(
        # Full path of the executable to register
        [Parameter(Mandatory=$true)]
        [string]$ExePath,
        [string]$Name,
        # Register application only for the current user. By default registration is for the machine
        [switch]$User
    )

    if (!(Test-Path $ExePath)) { throw "Path doesn't exist: $ExePath" }
    if (!$Name) { $Name = Split-Path $ExePath -Leaf } else { $Name = $Name + '.exe' }

    $appPathKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$Name"
    if ($User) { $appPathKey = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$Name" }

    If (!(Test-Path $AppPathKey)) { New-Item "$AppPathKey" | Out-Null }
    Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value $ExePath
}
