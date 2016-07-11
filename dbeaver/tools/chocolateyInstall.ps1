$ErrorActionPreference = 'Stop'

$packageName = 'dbeaver'
$url32       = 'http://dbeaver.jkiss.org/files/3.7.1/dbeaver-ee-3.7.1-x86-setup.exe'
$url64       = 'http://dbeaver.jkiss.org/files/3.7.1/dbeaver-ee-3.7.1-x86_64-setup.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
