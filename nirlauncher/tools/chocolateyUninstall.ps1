$ErrorActionPreference = 'Stop'

$packageName  = 'nirlauncher'
$install_path = "$(Get-ToolsLocation)\NirLauncher"

Write-Host "Removing $packageName from the '$install_path'"
rm $install_path -Recurse -Force -ea 0

$new_path = $Env:Path.Replace(";$install_path\Nirsoft", '')
if ($new_path -eq $Env:PATH) { return }
Write-Host "Removing $packageName from system PATH"
[System.Environment]::SetEnvironmentVariable('PATH', $new_path, 'Machine')

Write-Host "Removing $packageName shim"
Uninstall-BinFile $packageName
