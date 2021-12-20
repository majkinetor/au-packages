$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'msi'
  file           = gi $toolsPath\windows-i686-installer\*.msi
  file64         = gi $toolsPath\windows-x86_64-installer\*.msi
  silentArgs     = '/q'
  validExitCodes = @(0)
  softwareName   = 'Nicotine+ *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" }}
