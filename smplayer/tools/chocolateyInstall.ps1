$ErrorActionPreference = 'Stop'

$toolsDir      = Split-Path $MyInvocation.MyCommand.Definition
$installerFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') { gi "$toolsDir\*x64.exe" } else { gi "$toolsDir\*win32.exe" }

$packageArgs = @{
  packageName    = 'smplayer'
  fileType       = 'exe'
  softwareName   = 'smplayer*'
  file           = "$installerFile"
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for them
rm $toolsDir\*.exe -ea 0 -force

