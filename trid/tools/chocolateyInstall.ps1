$ErrorActionPreference = 'Stop'

$packageName = 'trid'
$url_trid    = 'http://mark0.net/download/trid_w32.zip'
$checksum    = 'EA7F82363912F5B3C79217BA8716425EC3F2514887F788DCD5A2821D0B1FC83F'
$url_trid_db = 'http://mark0.net/download/triddefs.zip'
$tools_path  = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $packageName
  url           = $url_trid
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = $tools_path
}
Install-ChocolateyZipPackage @packageArgs

Write-Host "Installing the latest trid database"
Get-WebFile $url_trid_db $tools_path\triddefs.zip
Get-ChocolateyUnzip $tools_path\triddefs.zip $tools_path
rm $tools_path\triddefs.zip

