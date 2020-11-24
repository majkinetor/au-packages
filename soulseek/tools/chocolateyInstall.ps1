$ErrorActionPreference = 'Stop'

$p = Get-Process SoulseekQt -ea 0
if ($p) { Write-Host "Stopping running process"; $path = $p.Path; Stop-Process $p }

$packageArgs = @{
  packageName            = $Env:ChocolateyPackageName
  fileType               = 'EXE'
  url64bit               = 'https://www.slsknet.org/SoulseekQt/Windows/SoulseekQt-2019-7-22-64bit.exe'
  checksum               = 'f72eb1f5581cc460e1cac912aac998e023b52b7bd365d888e59293cec63742ac'
  checksumType           = 'SHA256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes         = @(0)
  registryUninstallerKey = 'SoulseekQt*'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

if ($path) { Write-Host "Restarting Soulseek"; & $path }
