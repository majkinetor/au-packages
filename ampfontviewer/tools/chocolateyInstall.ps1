$ErrorActionPreference = 'Stop'

$packageName = 'ampfontviewer'
$url32       = 'http://www.ampsoft.net/files/FontViewer.zip'

$packageArgs = @{
  packageName   = $packageName
  url           = $url32
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
