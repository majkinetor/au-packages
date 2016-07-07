$ErrorActionPreference = 'Stop'

$packageName = 'copyq'
$url         = 'https://github.com/hluk/CopyQ/releases/download/v2.7.1/copyq-2.7.1-setup.exe'

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

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation) { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

if ($installLocation -and $running) {
    Write-Host "CopyQ was running before update, starting it up again"
    start "$installLocation\copyq.exe"
}
