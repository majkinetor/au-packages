$ErrorActionPreference = 'Stop'

$packageName = 'wzgapher'
$url32       = 'http://www.walterzorn.de/en/app/wzgrapher_e.zip'
$checksum32  = '0B48BF5CB477D7247CACBE500B1C52B9B9502FFF876275CD643560AB2FEDC60D'

$packageArgs = @{
  packageName   = $packageName
  url           = $url32
  checksum      = $checksum32
  checksumType  = 'sha256'
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
