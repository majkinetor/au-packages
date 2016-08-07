$ErrorActionPreference = 'Stop'

$packageName = 'wkhtmltopdf'
$url32       = 'http://download.gna.org/wkhtmltopdf/0.12/0.12.3.2/wkhtmltox-0.12.3.2_msvc2013-win32.exe'
$url64       = 'http://download.gna.org/wkhtmltopdf/0.12/0.12.3.2/wkhtmltox-0.12.3.2_msvc2013-win64.exe'
$checksum32  = 'F75F1C58470BE5FC71BABDF9E14C9DD9E801F7549354F7E1CF4AB1FA7BD5D962'
$checksum64  = 'E7DF45C7FF3B703C5938B66EA3DC0BD951C8E4ED07285E16FBD609E1DB431FED'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = 'wkhtmltox'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

if ($installLocation) {
    Install-BinFile wkhtmltopdf   "$installLocation\bin\wkhtmltopdf.exe"
    Install-BinFile wkhtmltoimage "$installLocation\bin\wkhtmltoimage.exe"
    Write-Host "$packageName installed to '$installLocation'"
}
