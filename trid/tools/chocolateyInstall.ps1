$ErrorActionPreference = 'Stop'

$packageName = 'trid'
$url_trid    = 'http://mark0.net/download/trid_w32.zip'
$url_trid_db = 'http://mark0.net/download/triddefs.zip'

$packageArgs = @{
  packageName   = $packageName
  url           = $url_trid
  #unzipLocation = "$ENV:ChocolateyInstall\bin"
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
$packageArgs.url = $url_trid_db
Install-ChocolateyZipPackage @packageArgs
