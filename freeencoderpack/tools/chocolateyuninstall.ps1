$ErrorActionPreference = 'Stop';
 
$packageName = 'freeencoderpack'

[array]$key = Get-UninstallRegistryKey -SoftwareName "foobar2000*"

if ($key.Count -eq 1) {
    $Path = $key.InstallLocation + '\' + 'encoders';
    Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue;

} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}