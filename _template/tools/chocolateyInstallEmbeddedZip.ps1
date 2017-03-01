$ErrorActionPreference = 'Stop'

$toolsDir      = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; gi "$toolsDir\*_x64.zip"
} else { Write-Host "Installing 32 bit version"; gi "$toolsDir\*_x32.zip" }

$packageArgs = @{
    PackageName  = ''
    FileFullPath = $embedded_path
    Destination  = $toolsDir
}
Get-ChocolateyUnzip @packageArgs
rm $toolsDir\*.zip -ea 0
