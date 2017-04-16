Write-Host "Uninstalling all versions of module InvokeBuild"

if (!(Test-Path $Env:ProgramFiles\WindowsPowerShell\Module\InvokeBuild)) {
    Write-Host "Module not found, it is uninstalled some other way"
    return
}
rm $Env:ProgramFiles\WindowsPowerShell\Module\InvokeBuild -Force -Recurse
Write-Host "Module InvokeBuild uninstalled"