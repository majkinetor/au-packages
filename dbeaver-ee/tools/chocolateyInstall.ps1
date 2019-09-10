$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'dbeaver-ee'
  fileType               = 'EXE'
  url                    = 'https://dbeaver.com/files/6.2.0/dbeaver-ee-6.2.0-x86-setup.exe'
  url64bit               = 'https://dbeaver.com/files/6.2.0/dbeaver-ee-6.2.0-x86_64-setup.exe'
  checksum               = '9df065080c0fdeab0b7dc0ef9ac5320fd5cba577cc57a57b43e93361a0226084'
  checksum64             = '3e42c05ca280b00a4178665cc1805597811e64a1ee2ea564d589bea725b63154'
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
