$ErrorActionPreference = 'Stop'

$packageName = 'wzgapher'
$url32       = 'http://www.walterzorn.de/en/app/wzgrapher_e.zip'

$packageArgs = @{
  packageName   = $packageName
  url           = $url32
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
