$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
    Write-Host "Installing 64 bit version"
    mv $toolsDir\Fab_x64.exe $toolsDir\Fab.exe -Force
} else {
    Write-Host "Installing 32 bit version"
    rm $toolsDir\Fab_x64.exe
}
