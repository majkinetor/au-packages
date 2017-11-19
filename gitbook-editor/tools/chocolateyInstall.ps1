$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'GitBook Editor'
  fileType       = 'exe'
  file           = gi $toolsPath\*.exe
  silentArgs     = '--silent'
  validExitCodes = @(0)
  softwareName   = 'GitBook Editor'
}
Install-ChocolateyInstallPackage @packageArgs
