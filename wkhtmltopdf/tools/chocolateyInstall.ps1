$ErrorActionPreference = 'Stop'

$packageName = 'wkhtmltopdf'
$url32       = 'http://download.gna.org/wkhtmltopdf/0.12/0.12.4/wkhtmltox-0.12.4_msvc2015-win32.exe'
$url64       = 'http://download.gna.org/wkhtmltopdf/0.12/0.12.4/wkhtmltox-0.12.4_msvc2015-win64.exe'
$checksum32  = '6883d1456201bc9d421cb7dd32a99458be3d56631ea4f292e51b3c1aecbe2723'
$checksum64  = '14a5996adc77dc606944dbc0dc682bff104cd38cc1bec19253444cb87f259797'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url32
  url64bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'wkhtmltox*'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }

if ($installLocation) {
    Install-BinFile wkhtmltopdf   "$installLocation\bin\wkhtmltopdf.exe"
    Install-BinFile wkhtmltoimage "$installLocation\bin\wkhtmltoimage.exe"
    Write-Host "$packageName installed to '$installLocation'"
}
