Write-Host "Installing module to $Env:ProgramFile\WindowsPowerShell\Module"

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
cp $toolsDir\InvokeBuild $Env:ProgramFiles\WindowsPowerShell\Module