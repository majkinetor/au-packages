<#
    Last Change: 17-May-2016.
    Author: M. Milic <miodrag.milic@gmail.com>

.SYNOPSIS
    Get application install location

.DESCRIPTION
    Functions tries to find install location in multiple places. It returns empty string if all fail.

.EXAMPLE
    Get-AppInstallLocation copyq

    Return the install location of the application 'copyq'.
#>
function Get-AppInstallLocation {
    [CmdletBinding()]
    param(
        #Regular expression pattern
        [ValidateNotNullOrEmpty()]
        [string] $AppNamePattern
    )

    function strip($path) { if ($path.EndsWith('\')) { return $path -replace '.$' } }

    $ErrorActionPreference = "SilentlyContinue"

    $local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    $machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
    $machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    $key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) | ? { $_.DisplayName -match $AppNamePattern }
    if (!$key) { return '' }

    Write-Debug "Trying Uninstall key 'InstallLocation'"
    $location = $key.InstallLocation
    if ($location -and (Test-Path $location))  { return strip $location }

    Write-Debug "Trying Uninstall key 'UninstallString'"
    $location = $key.UninstallString
    if ($location -and (Test-Path (Split-Path $location)))  { return strip $location }

    Write-Debug "Trying Program Files with 2 levels depth"
    $dirs = $Env:ProgramFiles, ${ENV:ProgramFiles(x86)}, "$Env:ProgramFiles\*", "${ENV:ProgramFiles(x86)}\*"
    $location = (ls $dirs | ? {$_.PsIsContainer}) -match $AppNamePattern | select -First 1 | % {$_.FullName}
    if ($location -and (Test-Path $location))  { return strip $location }

    Write-Debug "Trying PATH"
    $location = (Get-Command -CommandType Application) -match $AppNamePattern | select -First 1 | % { Split-Path $_.Source }
    if ($location -and (Test-Path $location))  { return strip $location }

    $appPaths =  "\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
    Write-Debug "Trying Registry keys: $appPaths"
    $location = (ls "HKCU:\$appPaths", "HKLM:\$appPaths") -match $AppNamePattern | select -First 1
    if ($location -and (Test-Path (Split-Path $location)))  { return strip $location }
}
