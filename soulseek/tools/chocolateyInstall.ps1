$ErrorActionPreference = 'Stop'

$p = Get-Process SoulseekQt -ea 0
if ($p) { Write-Host "Stopping running process"; $path = $p.Path; Stop-Process $p }

$packageArgs = @{
  packageName            = $Env:ChocolateyPackageName
  fileType               = 'EXE'
  url64bit               = 'https://f004.backblazeb2.com/file/SoulseekQt/SoulseekQt-2024-2-1-64bit.exe'
  checksum64             = '34c13a6969fcab41b75ac514d8d42069d0dc2bf13f024c1b0590aef38991cc08'
  checksumType64         = 'SHA256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes         = @(0)
  registryUninstallerKey = 'SoulseekQt*'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

if ($path) { Write-Host "Restarting Soulseek"; & $path }
