<#
    Last Change: 17-May-2016.
    Author: M. Milic <miodrag.milic@gmail.com>

.SYNOPSIS
    Get application install location

.DESCRIPTION
    Function tries to find install location in multiple places. It returns $null if all fail. The following
    locations are tried:
      - local and machine (x32 & x64) Uninstall keys
      - x32 & x64 Program Files up to the 2nd level of depth
      - native commands available via PATH
      - locale and machine registry key SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths

.EXAMPLE
    Get-AppInstallLocation choco

    Return the install location of the application 'choco'.
.OUTPUTS
    [String] or $null
#>
function Get-AppInstallLocation {
    [CmdletBinding()]
    param(
        # Regular expression pattern
        [ValidateNotNullOrEmpty()]
        [string] $AppNamePattern
    )

    function strip($path) { if ($path.EndsWith('\')) { return $path -replace '.$' } else { $path } }

    $ErrorActionPreference = "SilentlyContinue"

    Write-Verbose "Trying local and machine (x32 & x64) Uninstall keys"
    $local_key       = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    $machine_key     = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
    $machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    [array]$key = Get-ItemProperty @($machine_key6432, $machine_key, $local_key) | ? { $_.DisplayName -match $AppNamePattern }
    if ($key.Count -eq 1) {
        Write-Verbose "Trying Uninstall key property 'InstallLocation'"
        $location = $key.InstallLocation
        if ($location -and (Test-Path $location))  { return strip $location }

        Write-Verbose "Trying Uninstall key property 'UninstallString'"
        $location = $key.UninstallString.Replace('"', '')
        if ($location) { $location = Split-Path $location }
        if ($location -and (Test-Path $location))  { return strip $location }
    } else { Write-Verbose "Found $($key.Count) keys" }

    Write-Verbose "Trying Program Files with 2 levels depth"
    $dirs = $Env:ProgramFiles, ${ENV:ProgramFiles(x86)}, "$Env:ProgramFiles\*", "${ENV:ProgramFiles(x86)}\*"
    $location = (ls $dirs | ? {$_.PsIsContainer}) -match $AppNamePattern | select -First 1 | % {$_.FullName}
    if ($location -and (Test-Path $location))  { return strip $location }

    Write-Verbose "Trying native commands on PATH"
    $location = (Get-Command -CommandType Application) -match $AppNamePattern | select -First 1 | % { Split-Path $_.Source }
    if ($location -and (Test-Path $location))  { return strip $location }

    $appPaths =  "\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
    Write-Verbose "Trying Registry keys: $appPaths"
    $location = (ls "HKCU:\$appPaths", "HKLM:\$appPaths") -match $AppNamePattern | select -First 1
    if ($location) { $location = Split-Path $location }
    if ($location -and (Test-Path $location))  { return strip $location }

    Write-Verbose "No location found"
}
