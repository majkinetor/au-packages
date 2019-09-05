$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'dbeaver-ee'
  fileType               = 'EXE'
  url                    = 'https://dbeaver.com/files/6.1.0/dbeaver-ee-6.1.0-x86-setup.exe'
  url64bit               = 'https://dbeaver.com/files/6.1.0/dbeaver-ee-6.1.0-x86_64-setup.exe'
  checksum               = '07bbe3ef14b1000105dfbc3c43a44de01a07e011df0555addb4b9affcdea986c'
  checksum64             = 'b1e570b55ff33db4fba461da566c9c4d936aa21725a575ed13c35f8d6a557f69'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S /allusers'
  validExitCodes         = @(0)
  softwareName           = 'DBeaverEE *'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find install location"; return }
Write-Host "Installed to '$installLocation'"

Register-Application "$installLocation\dbeaver.exe"
Write-Host "DBeaverEE registered as dbeaver"
