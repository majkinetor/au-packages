$moduleName = 'InvokeBuild'

Write-Host "Uninstalling all versions of module $moduleName"

if (!(Test-Path $Env:ProgramFiles\WindowsPowerShell\Modules\$moduleName)) {
    Write-Host "Module not found, it is uninstalled some other way"
    return
}
rm $Env:ProgramFiles\WindowsPowerShell\Modules\$moduleName -Force -Recurse
Write-Host "Module $moduleName uninstalled"
