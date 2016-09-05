$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.7.3/dbeaver-ee-3.7.3-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.7.3/dbeaver-ee-3.7.3-x86_64-setup.exe'
$checksum32  = 'a4e89eabf67a7f92a2112cc99995f46225bd566c856dbf0feee67bb261cee70f'
$checksum64  = 'cf1b22a961f132b16573638526770bf262c8c0697e29ba1585594e9fa8540f33'


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
