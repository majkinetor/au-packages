$ErrorActionPreference = 'Stop'

$packageName = 'trid'
$url_trid    = 'http://goo.gl/aJVb'
$url_trid_db = 'http://goo.gl/Bnw1'

$packageArgs = @{
  packageName   = $packageName
  url           = $url_trid
  #unzipLocation = "$ENV:ChocolateyInstall\bin"
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
$packageArgs.url = $url_trid_db
Install-ChocolateyZipPackage @packageArgs
