$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$moduleName = 'InvokeBuild'

Write-Host "Installing module $moduleName to $Env:ProgramFiles\WindowsPowerShell\Modules"
cp $toolsDir\$moduleName $Env:ProgramFiles\WindowsPowerShell\Modules -Force -Recurse
