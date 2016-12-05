$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.8.1/dbeaver-ee-3.8.1-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.8.1/dbeaver-ee-3.8.1-x86_64-setup.exe'
$checksum32  = 'dd469a5d1d6b109280fa3bbd7a6bd8361801e593d066855be6d3e5fe22ceabdc'
$checksum64  = 'b48f2b128f9e15804a2266158488747e7be591ace7fad69c275932e83f763c4a'


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
