$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = $fileType
  file           = Get-Item $toolsPath\*-win32.exe
  file64         = Get-Item $toolsPath\*-win64.exe
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
  softwareName   = 'wkhtmltox*'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" "" }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation "$packageName*"
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Install-BinFile wkhtmltopdf   "$installLocation\bin\wkhtmltopdf.exe"
Install-BinFile wkhtmltoimage "$installLocation\bin\wkhtmltoimage.exe"
Write-Host "$packageName installed to '$installLocation'"
