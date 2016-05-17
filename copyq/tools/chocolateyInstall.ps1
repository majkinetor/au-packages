$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$url         = 'https://github.com/hluk/CopyQ/releases/download/v2.7.0/copyq-2.7.0-setup.exe'

$running     = if (ps $packageName -ea 0) { $true } else { $false }

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }

if ($installLocation -and $running) {
    Write-Host "CopyQ was running before update, starting it up again"
    start "$installLocation\copyq.exe"
}
