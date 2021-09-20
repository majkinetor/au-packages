$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'msi'
  file           = Get-Item $toolsPath\*.msi
  silentArgs     = '/q'
  validExitCodes = @(0)
  softwareName   = 'Bespoke Synth*'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.msi | % { rm $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" }}
