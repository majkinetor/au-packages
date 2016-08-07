$ErrorActionPreference = 'Stop'

$packageName = 'trid'
$url_trid    = 'http://mark0.net/download/trid_w32.zip'
$checksum    = 'EA7F82363912F5B3C79217BA8716425EC3F2514887F788DCD5A2821D0B1FC83F'
$url_trid_db = 'http://mark0.net/download/triddefs.zip'

$packageArgs = @{
  packageName   = $packageName
  url           = $url_trid
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
$packageArgs.url = $url_trid_db


$packageArgs.checksum = ''
Install-ChocolateyZipPackage @packageArgs
