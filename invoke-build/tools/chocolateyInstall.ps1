$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$moduleName = 'InvokeBuild'

Write-Host "Installing module $moduleName to $Env:ProgramFiles\WindowsPowerShell\Modules"
$dstDirectory = "$Env:ProgramFiles\WindowsPowerShell\Modules\$moduleName\"
if ($PSVersionTable.PSVersion.Major -lt 5)
{
    $srcDirectory = "$toolsDir\$moduleName\*\*"
} else {
    $srcDirectory = "$toolsDir\$moduleName\*"
}

if (-not (Test-Path $dstDirectory)) {
    mkdir $dstDirectory | Out-Null
}
cp $srcDirectory $dstDirectory -Force -Recurse
