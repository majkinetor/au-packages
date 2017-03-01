$ErrorActionPreference = 'Stop'

$toolsDir      = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; gi "$toolsDir\*_x64.zip"
} else { Write-Host "Installing 32 bit version"; gi "$toolsDir\*_x32.zip" }

$packageArgs = @{
    PackageName  = 'html-tidy'
    FileFullPath = $embedded_path
    Destination  = $toolsDir
}
ls $toolsDir\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
rm $toolsDir\*.zip -ea 0
