$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'pandoc'
  fileType       = 'msi'
  # file           = gi "$toolsDir\*i386.msi"
  file64         = gi "$toolsDir\*_64.msi"
  silentArgs     = '/quiet'
  validExitCodes = @(0, 1223)
  softwareName   = 'Pandoc *'
}
Install-ChocolateyInstallPackage @packageArgs
rm ($toolsDir + '\*.' + $packageArgs.fileType)

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }

Write-Host "$packageName installed to '$installLocation'"
'pandoc', 'pandoc-citeproc' | % { Install-BinFile $_ $installLocation\$_.exe }
