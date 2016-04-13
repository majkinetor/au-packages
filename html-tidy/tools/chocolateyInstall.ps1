$ErrorActionPreference = 'Stop'

$packageName = 'html-tidy'
$url32       = 'https://github.com/htacg/tidy-html5/releases/download/5.2.0/tidy-5.2.0-win32.zip'
$url64       = 'https://github.com/htacg/tidy-html5/releases/download/5.2.0/tidy-5.2.0-win64.zip'

$packageArgs = @{
  packageName   = $packageName
  url           = $url32
  url64Bit      = $url64
  unzipLocation = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
