$ErrorActionPreference = 'Stop'

$packageName = 'ampfontviewer'
$url32       = 'http://www.ampsoft.net/files/FontViewer.zip'
$checksum32  = '1356F3976DCD54EEE73611D1617CA8D113EAE6C14FF0B8971A3D21444FD22554'

$packageArgs = @{
  packageName   = $packageName
  url           = $url32
  checksum      = $checksum32
  checksumType  = 'sha256'
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
