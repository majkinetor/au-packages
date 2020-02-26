$ErrorActionPreference = 'Stop'

$toolsPath     = Split-Path $MyInvocation.MyCommand.Definition
$installerPath = Get-Item $toolsPath\Free_Encoder_Pack-*.exe

$packageArgs = @{
  packageName   = 'freeencoderpack'
  fileType      = 'exe'
  file          = $installerPath
  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $installerPath -ea 0; if (Test-Path $installerPath) { Set-Content "$installerPath.ignore" "" }