$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkScript  = "$toolsDir\eacuninstall.ahk"

[array]$key = Get-UninstallRegistryKey -SoftwareName 'Exact Audio Copy*'

if ($key.Count -eq 1) {
  $key | % {
    AutoHotkey $ahkScript "$($_.UninstallString)"
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}