$ErrorActionPreference = 'Stop'

$packageName = 'wkhtmltopdf'
$url32       = 'http://download.gna.org/wkhtmltopdf/0.12/0.12.3.2/wkhtmltox-0.12.3.2_msvc2013-win32.exe'
$url64       = 'http://download.gna.org/wkhtmltopdf/0.12/0.12.3.2/wkhtmltox-0.12.3.2_msvc2013-win64.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
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
