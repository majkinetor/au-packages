$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.8.5/dbeaver-ee-3.8.5-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.8.5/dbeaver-ee-3.8.5-x86_64-setup.exe'
$checksum32  = 'fa9d27d3e9e212c68e46bfe1693e75a0a755919fb9ed7907360ebc190ab69e11'
$checksum64  = 'ff552ddd92dfd870248905687769297748014df4f0e317a7a9dfcb49ff0c2a37'

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
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
