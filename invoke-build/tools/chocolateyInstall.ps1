$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$moduleName = 'InvokeBuild'

Write-Host "Installing module $moduleName to $Env:ProgramFiles\WindowsPowerShell\Modules"
$destination = "$Env:ProgramFiles\WindowsPowerShell\Modules\$moduleName\"
if ($PSVersionTable.PSVersion.Major -lt 5)
{
    $source = "$toolsDir\$moduleName\*\*"
} else {
    $source = "$toolsDir\$moduleName\*"
}

# Copy-Item results differ depending on if destination exists or not
if (-not (Test-Path $destination)) {
    mkdir $destination | Out-Null
}
cp $source $destination -Force -Recurse