$ErrorActionPreference = 'Stop'

$packageName = ''
$url32 = ''
$url64 = ''

$packageArgs = @{
  packageName   = $packageName
  url           = $url32
  url64Bit      = $url64
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
