function Get-RunnerInstallDir() {
    $res = Get-WmiObject win32_service | ? {$_.Name -eq 'gitlab-runner'} | select -Expand PathName
    if (!$res) { 
        if (!(gcm gitlab-runner.exe -ea 0)) { return }
        $res = (gitlab-runner.exe --shimgen-help 2>&1) -match '^\s*Target:' -replace "Target:|'"
        $res = $res.Trim()
    }
    $res = $res -split '\\gitlab-runner.exe' | select -First 1
    if (Test-Path $res) { return $res }
}

function Add-ServiceLogonRight([string] $Username) {
    Write-Host "Enable ServiceLogonRight for $Username"
    
    $tmp = [System.IO.Path]::GetTempFileName()
    secedit /export /cfg "$tmp.inf" | Out-Null
    (gc -Encoding ascii "$tmp.inf") -replace '^SeServiceLogonRight .+', "`$0,$Username" | sc -Encoding ascii "$tmp.inf"
    secedit /import /cfg "$tmp.inf" /db "$tmp.sdb" | Out-Null
    secedit /configure /db "$tmp.sdb" /cfg "$tmp.inf" | Out-Null
    rm $tmp* -ea 0
}

function Add-User([string] $Username, [string] $Password ) {
    $user = Get-WmiObject win32_useraccount -Filter { LocalAccount = 'true' } | ? { $_.Name -eq $Username }
    if ($user) { Write-Host "User $Username already exists"; return } 

    Write-Host "Creating user $Username as local administrator"
    net user $Username $Password /add | Out-Null
    net localgroup Administrators $Username /add | Out-NUll
    $user = Get-WmiObject win32_useraccount -Filter { LocalAccount = 'true' } | ? { $_.Name -eq $Username }
    $user.PasswordExpires = $false
}


# Author: Miodrag Milic <miodrag.milic@gmail.com>
# Last Change: 23-Jun-2016.

<#
.SYNOPSIS
    Set Windows to automatically login as given user after restart and eventually execute a script

.DESCRIPTION
    Enable AutoLogon next time when the server reboots.
    It can trigger a specific Script to execute after the server is back online after Auto Logon.

.EXAMPLE
    Set-AutoLogon -Username "domain\user" -Password "my password"

.EXAMPLE
    Set-AutoLogon -Username "domain\user" -Password "my password" -LogonCount 3

.EXAMPLE
    Set-AutoLogon -Username "domain\user" -Password "my password" -Script "c:\test.bat"
.LINK
    https://github.com/majkinetor/posh/blob/master/MM_Admin/Set-AutoLogon.ps1
#>
function Set-AutoLogon {
    [CmdletBinding()]
    Param(
        #Provide the username that the system would use to login.
        [Parameter(Mandatory=$true)]
        [String]$Username,

        #Provide the Password for the User provided.
        [Parameter(Mandatory=$true)]
        [String]$Password,

        #Sets the number of times the system would reboot without asking for credentials, by default 100000.
        [String]$LogonCount=100000,

        #Script: Provide Full path of the script for execution after server reboot
        [String]$Script
    )

    $ErrorActionPreference = 'Stop'

    $RegPath   = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
    $RegROPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"

    Set-ItemProperty $RegPath "AutoAdminLogon"  -Value 1
    Set-ItemProperty $RegPath "DefaultUsername" -Value $Username
    Set-ItemProperty $RegPath "DefaultPassword" -Value $Password
    #Set-ItemProperty $RegPath "DefaultDomain" -Value $Env:USERDOMAIN

    $v = if ($LogonCount)  { $LogonCount } else { '' }
    Set-ItemProperty $RegPath "AutoLogonCount" -Value $v -Type DWord

    $v = if ($Script)  { $Script } else { '' }
    Set-ItemProperty $RegROPath "Set-Autologon" -Value $v
}
