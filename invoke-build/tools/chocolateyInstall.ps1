$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$moduleName = 'InvokeBuild'

Write-Host "Installing module $moduleName to $Env:ProgramFiles\WindowsPowerShell\Module"
cp $toolsDir\$moduleName $Env:ProgramFiles\WindowsPowerShell\Module
