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

$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) -ErrorAction SilentlyContinue | ? { $_.DisplayName -like "$($packageArgs.registryUninstallerKey)*" }
if ($key) {
    $installLocation = Split-Path $key.UninstallString.Replace('"', '')
    if (Test-Path $installLocation)  {
        Install-BinFile wkhtmltopdf "$installLocation\bin\wkhtmltopdf.exe"
        Install-BinFile wkhtmltoimage "$installLocation\bin\wkhtmltoimage.exe"
        Write-Host "$packageName installed to '$installLocation'"
    }
}
