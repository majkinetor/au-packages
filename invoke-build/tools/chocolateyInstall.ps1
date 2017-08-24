$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$moduleName = 'InvokeBuild'

Write-Host "Installing module $moduleName to $Env:ProgramFiles\WindowsPowerShell\Modules"
if ($PSVersionTable.PSVersion.Major -lt 5)
{
    $srcDirectory = "$toolsDir\$moduleName\*\"
} else {
    $srcDirectory = "$toolsDir\$moduleName"
}

cp $srcDirectory $Env:ProgramFiles\WindowsPowerShell\Modules\$moduleName -Force -Recurse
