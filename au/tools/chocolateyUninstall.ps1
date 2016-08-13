$ErrorActionPreference = 'Stop'

Write-Host "Uninstalling module au"
$module_dst = "$Env:UserProfile\Documents\WindowsPowerShell\Modules\$packageName\$Env:ChocolateyPackageVersion"
rm -force -recurse $module_dst
