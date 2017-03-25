$ErrorActionPreference = 'Stop'

$packageName = 'wkhtmltopdf'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; gi "$toolsDir\*_x64.exe"
} else { Write-Host "Installing 32 bit version"; gi "$toolsDir\*_x32.exe" }

$packageArgs = @{
  packageName    = $PackageName
  fileType       = 'exe'
  file           = $embedded_path
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
  softwareName   = 'wkhtmltox*'
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsDir\*.exe -ea 0

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $PackageName install location" }
Write-Host "$packageName installed to '$installLocation'"

Install-BinFile wkhtmltopdf   "$installLocation\bin\wkhtmltopdf.exe"
Install-BinFile wkhtmltoimage "$installLocation\bin\wkhtmltoimage.exe"
Write-Host "$packageName installed to '$installLocation'"
