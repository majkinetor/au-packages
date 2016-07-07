$ErrorActionPreference = 'Stop'

$packageName = ''
$url32 = ''
$url64 = ''
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $packageName
  url           = $url32
  url64Bit      = $url64
  unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
