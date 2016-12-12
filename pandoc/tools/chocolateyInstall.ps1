$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'pandoc'
  fileType       = 'msi'
  file           = gi "$toolsDir\*.msi"
  silentArgs     = '/quiet'
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
rm ($toolsDir + '\*.' + $packageArgs.fileType)

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $PackageName install location"; return }

Write-Host "$packageName installed to '$installLocation'"
Install-BinFile $packageName $installLocation\pandoc.exe
