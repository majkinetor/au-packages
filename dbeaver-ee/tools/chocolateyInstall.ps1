$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'dbeaver-ee'
  fileType               = 'EXE'
  url                    = 'https://dbeaver.com/files/6.3.0/dbeaver-ee-6.3.0-x86-setup.exe'
  url64bit               = 'https://dbeaver.com/files/6.3.0/dbeaver-ee-6.3.0-x86_64-setup.exe'
  checksum               = '587417ccbf242aec046f6faba3bd46d56a3018a19588cb1fcc69e72393bf0884'
  checksum64             = '17ca0fd221a7a882f5c9559e2fb4b903b7f3354cf4e95ec60c982733ec2c3c41'
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
